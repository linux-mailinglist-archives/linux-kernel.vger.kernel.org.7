Return-Path: <linux-kernel+bounces-816866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C8BB57996
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1115B4E1E51
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9C53043A0;
	Mon, 15 Sep 2025 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D9FbIUlY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525652FE56D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937540; cv=none; b=UBuxmej3jZlDQcBPcwTmlmO6qASMuLHN46kouUwgWnchH7VcIh7YxpgM2XYPS0MaQHcOLByF4mf7EdxyCubHjFn11FBnvTSCdY8zYqXMNs4oJcOP/rqXwBL/UT7nH7KPcWtIwUyiiu0NBe9M1mEjZhEwO/LfOGyVkODuLlwWL40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937540; c=relaxed/simple;
	bh=LgCFVFN4Ma3avEiWjA83ikTL6fC+6c1II0g9R/QKREA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYYLnevNNH8HwysqN7hVb1MnmTfegTE/NW+SFLN2Zhi71+fDGtY8H8jICA5RaeNj/sHrV3cn0/i8tendfXZ2HeAHDfmWNeudvPw5QgWxSQ1sM94b7YuaYLdgWpTK8OpXTr+GGG5iRFVWA7domb5pi9NmkWxAQsGisvWeSEQWNy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D9FbIUlY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8G6kO009023
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O9Y91Mi9c6sVbop+7ZRsi0PmV9tUsrr5aJXQ5MNmIsQ=; b=D9FbIUlYDTZ9dCLs
	rkXnGI33Co+PxA1McGEmjkn4J+M48QcrLL+jje0jxxfqsHctPLUubJZTq981HUlh
	Q6EDKhkySonBO7Dn+rr9T4XF8yE8mPOrzhq+7PLRVC1hdiYR3eOEGAB1mawIyz8q
	+SlU1N6PZ7CXuLtIeRdxmDSbaOGbPbw7/KAw/fM298yOez+RDdJ6HmhCGhGqSE3d
	ltH5ByU1vMw7DF5kXWLDeKr6H8LP1xiv99ohAFjQZd4NvHnEr3kn+M3hdVYGyA0+
	XkWaoih0C60fPRu18LyOas2uFrOpcim24+4bjasxdG5GLbAQRe+GExdnlgEHSgW8
	YUnioA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495eqpungq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:58:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-329cb4c3f78so3675220a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757937537; x=1758542337;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9Y91Mi9c6sVbop+7ZRsi0PmV9tUsrr5aJXQ5MNmIsQ=;
        b=w63BFXnxSuOiG32ZxPEBuzy5Y+waJze3NvjP1o/Dpmd9NRYvjF4u1gXhbIkmhaelSG
         BkXOmYNHJCFIvI7TzK6togQWleocBCJe5/wOagUweTALBQD4GlXmR/82yyY1qLQGjZb9
         J//uWkm2tR3kx6oGp9+ABGBSNlWh7tsiVPokyyc32bZwxyj+NbsnUTKd5kQ2VvrtrCSU
         SMaATeFBvgDQPnwnO9DeCEUiMSr9W2ofKvpfkw6+OTF690jlr2dXkkOzQ27iLedycGw9
         iVSTRS72SFSYLwTdXKg4lneZCbIzDEdk2ZpVZUXEkvqsL0IaTGQzDlmIVZk2GtjOVq/a
         cLMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUl1YDqPXRWw64tPOw/AkpzgerYWkifnc3JeVhUqpBTsQu/srJe09QyFQq2acWH+npEqOousqGOMQLYwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSQ1g4RvjjPqXbst8vfr8481z4gR0EoksQ/II6r3mWj+ov/iwh
	Gfy3b5cEIN8RdBlhoW+35rNxm9AUSHazB2oc4ED1UqNW2jx46MG7UfSdHW4mallsaCQAlAPZLUj
	AGDJgV1CDu/5IlOcKERaxit8MkS1DbMjy9YpLBfHOaIiZ4McHtyKp/hTpZKwFsWBJOu4=
X-Gm-Gg: ASbGncs4CGv4a922mjBskANCG/UVFLNW9WXTlrCHGu9JItP2J8QlEuOAYiZG6HW/uid
	CvILFJ5+E8wHR4U5yn9jozGNIsz6jmkYsTjhfWXJsvmxrIB4IZUw+QJHh9mxgFacNmbYQhe0+oH
	tJ86eQG1bj8FYggHVco1GimnSOW3M4D6XH1kqG608c8K0ftkGO9x7uaAodDdY8dfvAwRDMC3YuU
	bRGN2+qT0WVvCVN2Reai5ndlVTw3aERaXujJ4hQmcx3dXpqtNgUGJdzwseX2BeHD6xVdxQDtd8Y
	1R+FpRbJHfXT7b+0zew8CtJvPb0xNZ+jMfjb6SbFH9nm1rkdoiMXLQ==
X-Received: by 2002:a17:90b:5145:b0:32b:9750:10e4 with SMTP id 98e67ed59e1d1-32de4f982b2mr13969938a91.27.1757937537399;
        Mon, 15 Sep 2025 04:58:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtbghQHq0gu3/yYi4bmubcUDLU1XWygObo3IOE8IqMLklbmQSQgIOtfaHyHtpJVC93qjmZow==
X-Received: by 2002:a17:90b:5145:b0:32b:9750:10e4 with SMTP id 98e67ed59e1d1-32de4f982b2mr13969904a91.27.1757937536906;
        Mon, 15 Sep 2025 04:58:56 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793b6b1sm13152436b3a.20.2025.09.15.04.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:58:56 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:28:51 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, andrew@lunn.ch
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: qcom: qca808x: Add .get_rate_matching
 support
Message-ID: <aMf/e5GfO9HyU+n0@oss.qualcomm.com>
References: <20250914-qca808x_rate_match-v1-1-0f9e6a331c3b@oss.qualcomm.com>
 <aMcFHGa1zNFyFUeh@shell.armlinux.org.uk>
 <aMfUiBe9gdEAuySZ@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMfUiBe9gdEAuySZ@oss.qualcomm.com>
X-Proofpoint-GUID: pntYETyxwfq8PbKg9TV3PXCihJ_sUuls
X-Proofpoint-ORIG-GUID: pntYETyxwfq8PbKg9TV3PXCihJ_sUuls
X-Authority-Analysis: v=2.4 cv=XJIwSRhE c=1 sm=1 tr=0 ts=68c7ff82 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=P-IC7800AAAA:8 a=trpLnoLhJh18tURxHDYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDE4NiBTYWx0ZWRfX52uY8xrj2ezy
 4YB9TQk+q3JlGOT6iK5d/B0XyEmKH8NI11arCaHb0nl48p4/B+Y+kxe4O0etV1pZ3IKS2SzNMot
 Kof+hcRSaV2ZHR7lyebOn6vwv/XiD+ciVgwehcuIN+TKh0qHrwiRMa5klHIO2T9ZAoRvGM/B0h/
 rIvbNtn9KakEpt5PPQubMbymtEjPB2x19tyvAgQa6CYGNr2I2Ax0qeEbZ+9cDsUCUWnElDne0b6
 5UZQZr96Kp7sOIoFrU3R1d1SHczLG7k2PWbpfTQUNm0XUGkyiIue8EnvsmTIVy2U7iu4H842hUp
 3V1DbDFIqO35WCpWpZxfuO5K8DoDP2Xl6qZIxZzx37/1lXU64dK2+Dumcf2qOAvSIjlLfcIEKJw
 o4atSWLK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130186

On Mon, Sep 15, 2025 at 02:25:42PM +0530, Mohd Ayaan Anwar wrote:
> On Sun, Sep 14, 2025 at 07:10:36PM +0100, Russell King (Oracle) wrote:
> > On Sun, Sep 14, 2025 at 08:36:48PM +0530, Mohd Ayaan Anwar wrote:
> > > Add support for rate matching to the QCA8081 PHY driver to correctly
> > > report its capabilities. Some boards[0][1] with this PHY currently
> > > report support only for 2.5G.
> > > 
> > > Implement the .get_rate_matching callback to allow phylink to determine
> > > the actual PHY capabilities and report them accurately.
> > 
> > Sorry, but this is incorrect.
> > 
> > The PHY does not support rate matching, but switches between SGMII
> > and 2500BASE-X depending on the negotiated speed according to the code:
> > 
> > static void qca808x_fill_possible_interfaces(struct phy_device *phydev)
> > {
> >         unsigned long *possible = phydev->possible_interfaces;
> > 
> >         __set_bit(PHY_INTERFACE_MODE_SGMII, possible);
> > 
> >         if (!qca808x_is_1g_only(phydev))
> >                 __set_bit(PHY_INTERFACE_MODE_2500BASEX, possible);
> > }
> > 
> > static int qca808x_read_status(struct phy_device *phydev)
> > {
> > ...
> >         if (phydev->link) {
> >                 if (phydev->speed == SPEED_2500)
> >                         phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
> >                 else
> >                         phydev->interface = PHY_INTERFACE_MODE_SGMII;
> >         } else {
> > 
> > The driver certainly does not support rate-matching, even if the PHY
> > can support it, and even with your patch. All you are doing is making
> > ethtool suggest that other speeds are supported, but I think you'll
> > find that if the PHY negotiates those speeds, it won't work.
> > 
> 
> Weirdly, I was able to test both 1G and 2.5G with my patch. Could this
> be because the driver is already deviating from the standard in other
> areas?
> 
> > So, the bug is likely elsewhere, or your ethernet MAC doesn't support
> > SGMII and you need to add complete support for  rate-matching to the
> > driver.
> > 
> 
> I tried setting phy-mode=sgmii in the Devicetree and I am able to get 1G
> and lower speeds to work.
> 
> > Please enable phylink debugging and send the kernel messages so I can
> > see what's going on.
> > 
> 
> Filtered logs (without my patch):
> [    7.937871] qcom-ethqos 23040000.ethernet: IRQ eth_wake_irq not found
> [    7.944581] qcom-ethqos 23040000.ethernet: IRQ eth_lpi not found
> [    7.953753] qcom-ethqos 23040000.ethernet: User ID: 0x20, Synopsys ID: 0x52
> [    7.960927] qcom-ethqos 23040000.ethernet:   DWMAC4/5
> [    7.966049] qcom-ethqos 23040000.ethernet: DMA HW capability register supported
> [    7.973564] qcom-ethqos 23040000.ethernet: RX Checksum Offload Engine supported
> [    7.981073] qcom-ethqos 23040000.ethernet: TX Checksum insertion supported
> [    7.988139] qcom-ethqos 23040000.ethernet: TSO supported
> [    7.993603] qcom-ethqos 23040000.ethernet: Enable RX Mitigation via HW Watchdog Timer
> [    8.001654] qcom-ethqos 23040000.ethernet: Enabled L3L4 Flow TC (entries=8)
> [    8.008817] qcom-ethqos 23040000.ethernet: Enabled RFS Flow TC (entries=10)
> [    8.008819] qcom-ethqos 23040000.ethernet: Enabling HW TC (entries=128, max_off=64)
> [    8.008821] qcom-ethqos 23040000.ethernet: TSO feature enabled
> [    8.008822] qcom-ethqos 23040000.ethernet: SPH feature enabled
> [    8.008824] qcom-ethqos 23040000.ethernet: Using 36/40 bits DMA host/device width
> [    8.243500] qcom-ethqos 23040000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> [    8.253778] qcom-ethqos 23040000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-1
> [    8.261991] qcom-ethqos 23040000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-2
> [    8.262527] qcom-ethqos 23040000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-3
> [    8.348697] qcom-ethqos 23040000.ethernet eth0: PHY stmmac-0:1c uses interfaces 4,23, validating 23
> [    8.358304] qcom-ethqos 23040000.ethernet eth0:  interface 23 (2500base-x) rate match none supports 6,13-14,47
> [    8.368589] qcom-ethqos 23040000.ethernet eth0: PHY [stmmac-0:1c] driver [Qualcomm QCA8081] (irq=POLL)
> [    8.368595] qcom-ethqos 23040000.ethernet eth0: phy: 2500base-x setting supported 0000000,00000000,00008000,00006040 advertising 0000000,00000000,00008000,00006040
> [    8.381057] qcom-ethqos 23040000.ethernet eth0: Enabling Safety Features
> [    8.416398] qcom-ethqos 23040000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
> [    8.425541] qcom-ethqos 23040000.ethernet eth0: registered PTP clock
> [    8.434778] qcom-ethqos 23040000.ethernet eth0: configuring for phy/2500base-x link mode
> [    8.446169] qcom-ethqos 23040000.ethernet eth0: major config, requested phy/2500base-x
> [    8.454323] qcom-ethqos 23040000.ethernet eth0: interface 2500base-x inband modes: pcs=00 phy=00
> [    8.463353] qcom-ethqos 23040000.ethernet eth0: major config, active phy/outband/2500base-x
> [    8.471939] qcom-ethqos 23040000.ethernet eth0: phylink_mac_config: mode=phy/2500base-x/none adv=0000000,00000000,00000000,00000000 pause=00
> [    8.485780] 8021q: adding VLAN 0 to HW filter on device eth0
> [    8.489653] qcom-ethqos 23040000.ethernet eth0: phy link down 2500base-x/Unknown/Unknown/none/off/nolpi
> [   13.615848] qcom-ethqos 23040000.ethernet eth0: phy link up 2500base-x/2.5Gbps/Full/none/rx/tx/nolpi
> [   13.617924] qcom-ethqos 23040000.ethernet eth0: Link is Up - 2.5Gbps/Full - flow control rx/tx
> 
> // I changed the link partner speed to 1G here:
> [   74.031182] qcom-ethqos 23040000.ethernet eth0: phy link down 2500base-x/Unknown/Unknown/none/off/nolpi
> [   74.031773] qcom-ethqos 23040000.ethernet eth0: Link is Down
> 
> For reference, this board is using the same MAC as [0] which works
> perfectly fine with the AQR115C PHY. I got the (wrong) idea to add
> .get_rate_matching after comparing the two PHY drivers. The MAC driver
> is stmmac/dwmac-qcom-ethqos.c
> 
> 	Ayaan
> ---
> [0] https://elixir.bootlin.com/linux/v6.17-rc5/source/arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts

Sorry, I missed adding the following.

After checking the phylink logs, I am now wondering if we need to
register a `.get_interfaces` callback in `dwmac-qcom-ethqos.c` and
do something like:

case PHY_INTERFACE_MODE_2500BASEX:
	__set_bit(PHY_INTERFACE_MODE_2500BASEX, interfaces);
	fallthrough;
case PHY_INTERFACE_MODE_SGMII:
	__set_bit(PHY_INTERFACE_MODE_SGMII, interfaces);
	break;
...

This is based on my limited understanding, so I’d love to hear your
thoughts.

	Ayaan

