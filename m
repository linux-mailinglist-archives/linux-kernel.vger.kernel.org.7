Return-Path: <linux-kernel+bounces-821478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7D4B815B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800E262035D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D423009EE;
	Wed, 17 Sep 2025 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DD0K6u4b"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D91F2FF662
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758134190; cv=none; b=dQNKkozRDbWVrSTg58cDPZGbvOtd5vJk9PriRmrKBUSR82UsoMc8gJEhJM1Jj6xvY33brOYRhvODa+GfLyUzOdBnKH+q4KGbzVlMR2RzOH7OSJUF3pdQosgNr+uptz62EWL61O+ksgcKfqSmlqX3y8lM2JBJ+y2zPzicTXH/X3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758134190; c=relaxed/simple;
	bh=ShI2k9ivKU2ONLYeQn0ZPELa7RBfFm3UfEcjq3W58rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpro5Tf+IPEsT+yZMLtYaOhsrYoQRm5wK/rHudy54EgTQqJbU2IVaBbbFwfUWzQfnUFb2V5CDsZQ4Mge6yjCBiRkLF4ztBesLDFOGTTJGg+TboyOz7nQ0gXnSnvk+nrSctyUZYzvu81TsM8tn4in0jY77+UW4TNMJiNEhTWg4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DD0K6u4b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HDG3Nu003340
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G6gNK6B9Z2A4lta5LSCT5cUXyJCQpIdZ/ubmiF5QefM=; b=DD0K6u4bwE+LyV2M
	9H63lfkUvnBZGktna6oM0D2qFtT/PWfNP0YPoDh3EdO59A4UKUHpBfPCxP+d32D+
	nzp+d36A9L1RUt5GBMJ4YyWdpi/SsVD8C5/0m9ykQWHKZf+Oq470ofpmBWT5CpTR
	EkQYUBLbWckRXnIyqRZNSzH9rGbH9S2HGOWKjCfXffczo6DP+QfqlZvXqGo21HVL
	0nFDebM5/z2b/ybIfiHu1t0jF7sLWmtRGiNOaHeQRGXhiIgeBq3h1XRaK1c3OV9i
	UR0xm8bRsnviE0nd0JRc7t39/eJXe3+eqRnBvLJgj409f6D/FWzLaSFB4RRQ1C+y
	dZI8fA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497wqgs19g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:36:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b79d4154c9so740111cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758134185; x=1758738985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6gNK6B9Z2A4lta5LSCT5cUXyJCQpIdZ/ubmiF5QefM=;
        b=POEa7LGg4Gf1dt21tG0PTavLTP3Qq9SmmSgRtZvlELq418PWWib9NbwbeQv17DYXVf
         G2h8XJSFApIaizKCRQEZScrSALK5POE73Viyw8nekfiMByOjppMkuKJMsdSXCL+L5QCz
         20qEKoLcije34I4IECq6o9Y4iS+NsrTmCRQxnicN57HOHadcnQMugqNVRW4JvV7m5cEj
         vEi22EhBfPZfshePsHDCy0nY9NFQyBp5bVmF+VOKTxsu1+XYgy9ANIU9jBSA89L3P7Tk
         Ti2TFPWnVEpOepmGLoN/g+XtDCsR1MfVvJUAgpZa1SQqphxvys9vQWayuwgOkmvU7J/8
         HniA==
X-Forwarded-Encrypted: i=1; AJvYcCV6RGc577YIznBgeOI9X3FZtERiPNzMPyXSqbWmU7FG9YnPsoWWbLsXpwvFaM5CsdsCTwRA9T8qfK3Coyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNKXf3votrBibzF9t+vrtqaBVX/JIvNPcwj+tNllzKv1xlPMlJ
	ie0JdOYsMdOZ8h2McPBGtuhGwe3Powfq0v9VKNqGeShSgzdyM1OaF5GBe0kntgh/ZmHPiycATTl
	6GG0k/1/E/Q5YcBE46jDrJjM9Uypf5WrbV9XvfsECijlFIFOocQo9Nm2RxMg5gNYiI5k=
X-Gm-Gg: ASbGncuL2fVlOl/M3ew2ZQaA2ZV4rMmNxLDbmKxlOFH+ODs2X5WG8Zri9ULyI8KINyu
	uuZvxOJACOGkUGcKKNaTvPgqBfap76r5Xm7g4KanJeFIOe5VOIQI1xi1q7tY19y/1gC2hZpPZYQ
	ZxLC5QP5sC7dh2UXgCyHQekOeTrqHscJBFEqAJ2GXqTT3Zf2FbaMut79vDnKhJBMlFHpZ0aEC8P
	6OXkSihoKuyazUJbLcy4EBbTgxOE85sV0hZpZrC4qyYC2j0jv6Uh8bIEAaVCObtx3aoCnZ1726R
	fkLjg4G/VlRoVL0VYgyulHOgspbeIrP1XRbeB5SQEqV7mJFZkBgl/EvLP6Me06Y0CBoSpbJC2Rp
	hp2SOFbCr7+/W9Rrtb/94zg==
X-Received: by 2002:a05:622a:109:b0:4b7:8076:a18b with SMTP id d75a77b69052e-4ba6c1e8f28mr25265791cf.12.1758134184555;
        Wed, 17 Sep 2025 11:36:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLuRNGN9aEBJZ8GryG0uthn3tSIvqT4mf7CdTs+y8S8l0MhVt4Qree4ToiBP0C/0e4uJiEYA==
X-Received: by 2002:a05:622a:109:b0:4b7:8076:a18b with SMTP id d75a77b69052e-4ba6c1e8f28mr25265241cf.12.1758134183687;
        Wed, 17 Sep 2025 11:36:23 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5f4156esm59054a12.46.2025.09.17.11.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 11:36:23 -0700 (PDT)
Message-ID: <e648a71f-a642-4f5d-bcf8-893484cfe601@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 20:36:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] dt-bindings: thunderbolt: Add Qualcomm USB4 Host
 Router
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        Raghavendra Thoorpu <rthoorpu@qti.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mayank Rana <mayank.rana@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <westeri@kernel.org>,
        Yehezkel Bernat
 <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
References: <20250916-topic-qcom_usb4_bindings-v1-1-943ecb2c0fa7@oss.qualcomm.com>
 <20250917061236.GF2912318@black.igk.intel.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250917061236.GF2912318@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XAd53tcwDyYAN32ILv5ePvQVE0SZQAza
X-Authority-Analysis: v=2.4 cv=HITDFptv c=1 sm=1 tr=0 ts=68caffa9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=yMhMjlubAAAA:8 a=EUspDBNiAAAA:8
 a=6jotvRMCQIAsDOHH8VAA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: XAd53tcwDyYAN32ILv5ePvQVE0SZQAza
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDEyOCBTYWx0ZWRfX5EuSiBvYqgcE
 ztdH+LyG9+HUN9Io2+4rHOpYHOqXVXg20XFiw8IEeJ0boHQaNPB6xWobTdGM5XfG3Z6cRh9hbbu
 H+VQWzAs5dMWzi9icSv1qavgyoe7mg2ieYMUYDPxuVrIHrFYuIbH0lm/FyUfrkuxW/dGY5sbDi1
 4zvN59Hd4A7t/hVwLiEXIukrYgBnMzG84Ajd9mbB6DRTITJMKKQyislR+N1fFrpKdGuWYRiqDgQ
 zzi2yjxoSZD8mjHIi5RyfF2Nu5ldJqNmC0jluj4ps2L2pp8Hbv8F5eaFQXScJqNunMhwbJxMblX
 D+XBmjEg3bm5qsTI63WBQ23AAvNk/V0EoxmYLY+sjx0EDvjmxeKwpbrctHxcl9Ufvo/A+3A23z8
 jkYle/b3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170128

On 9/17/25 8:12 AM, Mika Westerberg wrote:
> Hi Konrad,
> 
> On Tue, Sep 16, 2025 at 10:06:01PM +0200, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

[...]

>> P.S.
>> The driver part (which has quite some dependencies) is not yet 100%
>> ready to share and will be published at a later date.
> 
> Okay, I think it is beter to submit the bindings with the driver changes so
> that we can see the big picture.

We're not going to do that just yet, but I'll give you the gist of it
(partially also responding to Dmitry's other reply to this email):

- The current thunderbolt implementation is almost entirely reused

- Our HR is MMIO-mapped and always present (i.e. it's not a PCIe device).
  Since the NHI code already uses I/O accessors, we simply ioremap() the
  NHI region and feed the existing code the __iomem ptr (really cool)

- Because it's not a PCIe device, all the places where the code assumes
  it can freehand dereference nhi->pdev are altered to instead consume
  a struct device *, i.e.:

diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index 75247486616b..d05f8d6896e7 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -493,22 +493,37 @@ static inline struct tb_xdomain *tb_service_parent(struct tb_service *svc)
  *                 MSI-X is used.
  * @hop_count: Number of rings (end point hops) supported by NHI.
  * @quirks: NHI specific quirks if any
+ * @is_pci: Whether the NHI is a PCI device
  */
 struct tb_nhi {
        spinlock_t lock;
-       struct pci_dev *pdev;
+       struct device *dev;
        const struct tb_nhi_ops *ops;
        void __iomem *iobase;
        struct tb_ring **tx_rings;
        struct tb_ring **rx_rings;
-       struct ida msix_ida;
        bool going_away;
        bool iommu_dma_protection;
        struct work_struct interrupt_work;
        u32 hop_count;
        unsigned long quirks;
+       bool is_pcie;
 };
 
+struct tb_nhi_pci {
+       struct pci_dev *pdev;
+       struct ida msix_ida;
+       struct tb_nhi nhi;
+};
+
+static inline struct tb_nhi_pci *nhi_to_pci(struct tb_nhi *nhi)
+{
+       if (WARN_ON(!nhi->is_pcie))
+               return NULL;
+
+       return container_of(nhi, struct tb_nhi_pci, nhi);
+}

I suppose I can probably get this decoupling sent in advance of the rest..
It's quite delicate so I'm hoping I won't cause any random nullptrs for you


- Additional steps are necessary to take the hardware out of reset, set
  some magic values here and there, load the firmware (i.e. memcpy_toio())
  wake up the MCU and perform Type-C magic (more on that below), all of
  which is handled in a new qcom_usb4.c, which does that and ends its probe
  function with a nhi_probe_common(). PM of the hardware and its providers
  also takes place in Linux, just like with any other IP block on embedded
  systems


- Because the Type-C pipeline varies wildly across Qualcomm SoCs and even
  devices using the same SoC, we need to register a typec_mux to receive
  generic (alt)mode notifications. The is more or less:

pmic_glink_altmode/ucsi (altmode notification provider)
|-> QMPPHY (Qualcomm proprietary USB4/TBT3/USB3/DP mode switchable PHY)
  |-> (optionally) Onboard switch (e.g. FSA4480)
    |-> (optionally) Onboard retimer (e.g. Parade PS883x)
      |-> USB4 HR (pinging the MCU with some mode/cable info)

The actual entry logic (sanity checking, magic VDMs, SOP/'/'' comms)
happen on a remote processor - Audio DSP (yes) in the case of X1E and
the OS is graciously presented with a trimmed-down notification that
the altmode has been entered and it better cooperate

[...]

>> +  reg-names:
>> +    items:
>> +      - const: router
>> +      - const: router_config
>> +      - const: tmu_config
>> +      - const: port_group
>> +      - const: sideband
>> +      - const: uc_ram
>> +      - const: uc_per
>> +      - const: uc_mbox
>> +      - const: nhi
>> +      - const: cfg
>> +      - const: debug
>> +      - const: usbap_config
>> +      - const: pcieap_config
>> +      - const: dpap0_aux
>> +      - const: dpap0_config
>> +      - const: dpap1_aux
>> +      - const: dpap1_config
> 
> Are these the specific to the host controller? I mean route_config sounds
> pretty much like Router Config space and that is available through the USB4
> fabric so not sure why this is listed?
> 
> Also this does not list the standard Host Interface registers, is that on
> purpose?

The 'nhi' region contains the entire spec-standardized set of registers,
everything else is qc-specific. The host router has internal connections
to the native protocol controllers, so the XXXap_config regions include some
tunables related to that.

The uc_ regions relate to the block's MCU.

router/router_config refer to top-level tunables or control/state registers.

tmu_config is the same, for the internal timing management unit.

debug/cfg are self-explanatory

Most of those will be left unused, but the binding has to be forward
looking, in case some sort of a software workaround is required down
the line

> 
>> +
>> +  interrupts:
>> +    items:
>> +      - description: Combined event interrupt for all three rings
>> +      - description: OOB Firmware interrupt
> 
> No MSI? If not then at least I suggest to support it in the DT description.

No, it seems like across the SoC we only have MSIs on the PCIe RCs

Because I don't know what a valid MSI setup would look like, I'd like
to defer adding that description to when a platform with them pops up

[...]

>> +  wakeup-source: true
> 
> What about the "power contract"? Are you using the existing we have for
> ACPI:
> 
> https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#map-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers
> 
> It was designed DT in mind but I don't think we have DT bindings for it.
> This is needed to make sure the driver (Connection Manager) creates the
> tunnels before the native protocol stacks get enumerated (e.g during power
> transitions).

I added a custom entry to drivers/of/property.c, matching that name.
Seems to work fine (tm) so far, but then we haven't yet tested sus/res
much.. 

Just to make sure - are we expected to ensure that the NHI device is
resumed before any protocol controller drivers (at runtime), or do the
latter have to *probe* only after they're necessary? I firmly believe
the former, but doesn't hurt to ask..

[...]
>> +            port {
>> +                usb4_0_mode_in: endpoint {
>> +                };
> 
> This describes the Downstream Facing Port (e.g USB4 port), right? We have
> something similar used in Chromebooks so it would be good if we can make
> the bindings close to each other if possible. This allows binding firmware
> description to retimers (and also to "fixed/embedded" device routers as
> recent changes to the USB4 spec makes possible).
> 
> See drivers/thunderbolt/acpi.c::tb_acpi_find_companion().

Yes, this binding assumes the Host Router has precisely 1 DFP (Linux
Type-C infra isn't ready for anything more, at least not on the DT side
to my knowledge) and this port (which isn't necessarily the same as a
connector, i.e. a physical receptacle in DT speak, it simply refers to
an abstract data connection between two devices)

Notably, I don't think we currently describe the USB4 port (as in, the
usb4_port.c meaning of it) at all, but for on-SoC HRs we know all about
them, so perhaps a subnode description could make sense. This way we
could also point them to the compatible = "usb-c-connector" node

Konrad

