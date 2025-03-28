Return-Path: <linux-kernel+bounces-579508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016F4A74441
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 08:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF93D189371D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 07:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6443917A5BE;
	Fri, 28 Mar 2025 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YgrC65eo"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA122318
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743146193; cv=none; b=KLwM8xQvfMB1aLxkQlorfFs88/hLKFOQAf33yzvkw0KrnrUDEpf14mV7k/YtWtLIYVch7FMnwdHwznEYO2+lTFe/3WdzJLE9eWavVcSuoR+OEOyievwnF4WorE0fBeuoK9B7U/3N5DEVjc926iZ1CuZMLA8pMHVbZfoKItsiO8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743146193; c=relaxed/simple;
	bh=TKJevRNqOhkTY0h/YKrlLZg0MRUpwuJ18SAD/eNyIGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LC8rP5SrPc+25raCCRo5qdgJagJITzL2eSIzAfjySERc7IEMEzgJ6uhut/9VtcK4CFBcT1cxhZE/yu+PWzQpFxuckaM1j7Eqo+0pDo73c183+e7ZpJtWwC1+r6fYjnmaz1+RMnZ74PtdBGMQBh2XkVUs8A6+nxH+R0B+bLPm/9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YgrC65eo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-227c7e57da2so31470585ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 00:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743146191; x=1743750991; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3PegE+Cjkboiq51xGZf8q33++7d0FPsqepnmGrruHt0=;
        b=YgrC65eoHc+G8Z9UF/bRRFXl6isnZ1EWhzsV4VT51Wm8fUd+hu7r9RQJ/AhOAB5sNn
         UnX/iydSNmCHvaKt/nEj5eCigQtxc6FmXk/AxSYtJ5sxLcDoa+W7Xsub/rKroPNbBwXc
         716ehGDwW8DS0ju4zPhNYM+Qc907vmxGsHoZb3zs2BvXV67y3eV0XpJVxTEI0Gt3P8RT
         O/6cYx28sp847KFs3708W5SnycT1VeY0HH01Pgkt3SUkpsRyvV/4zKaItLt4zEY/9WWU
         wQSBiyHbtVWNo3ds5Shhzc+fthw8J1tZceCrqR1guksBVDbIbgxqEEuDQiUMKXYp+gbF
         dIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743146191; x=1743750991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3PegE+Cjkboiq51xGZf8q33++7d0FPsqepnmGrruHt0=;
        b=ZUInj/HkYqzMqVJkljJ+XJ0e82869MMjIy5S/BXZ2LufxDTOPXzJgfXGzMiuwBywtg
         wpgOlJtNiIBC34WlkSIRZBHajBCgBE2A4QzQnL9tjNxfoIN3zmbtDh8+AE97lBPIlQts
         B3LzcaF12fJpfsyC4A1NkBZQTR8j257EOpNKBqoEILkRoMDOGOD24HoWO+UB7JTYt7Gc
         IPUxDFAGvQ9FO/s651IIVrzDM/XiU56CzaJ+wnmKFcvqJ9elj7yXOPWN7KSFqgx2U+QZ
         S9XWF4sQ9T73Mj9Px06CkYSkCbXyay1A1jqGh9fbSDkdnMotJ4GaGCpWHN4hUZs2ZgFT
         2hmg==
X-Forwarded-Encrypted: i=1; AJvYcCWp0s7op2N2Hv0Jvnum3CJ8fmD0Z3F16+PJi3ntN429HOGbN1iu+XaMz8ddbp1V8V4WBi17TmeHi31IrFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKuEqXnQyTc8hIR2V9FG3A04NUO7xlvHEv4uBUtHVJjT981VHM
	JepoRC+u9nULFQRtbEW5H6iqu/VeeSRvtJd+Ror2P1UTTpW8AeNBodv7nCMNjg==
X-Gm-Gg: ASbGncuoj18F7AFd+pkiG6X61otG5j6tI+WA9eScWESXAScUGc1mRVF3wct4WH7B75I
	ODs+8GS/r0JgSL+WUlC7ypMxDcsvr7DqjzdiRzl7bS1yCjOBN83aAmQQirPWA3xo85eJk3pVwXU
	MloG7Ddj6YQPqysS5GblVaOr7d+dfWiPnkdgBA/0JRhpyQnskESSE6iSSiEpZllnCZTGDnalCkc
	mTGSCYGbmX3QSqNUluV0URAIGSwHotAVx1BP/xD3o6ZsUywqOwKRCFiKsXTZuEkPQ7aVSL30nvx
	Aun++GiwP95wm1C0+gXxF4zMP/6On/TvkvmEruISvxLVb/7OpLoDcF4=
X-Google-Smtp-Source: AGHT+IF5UepItCcJSaeWzDfap9vxalQuYDYhnqB0lwk9s1M095ggieOIxfPLzD1T6Ad52VDSjIQciA==
X-Received: by 2002:a05:6a00:1405:b0:730:d5ca:aee with SMTP id d2e1a72fcca58-739610e20d9mr10149300b3a.23.1743146190944;
        Fri, 28 Mar 2025 00:16:30 -0700 (PDT)
Received: from thinkpad ([120.60.68.219])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e2e2bcsm1041441b3a.70.2025.03.28.00.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 00:16:30 -0700 (PDT)
Date: Fri, 28 Mar 2025 12:46:24 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v8 2/4] PCI: of: Add of_pci_get_equalization_presets() API
Message-ID: <gkyewqpwc5hxlyvjriqdpt2mkkg7dqvasbhmz72jdfwjtwnmni@sj7lyd2iil7l>
References: <20250316-preset_v6-v8-0-0703a78cb355@oss.qualcomm.com>
 <20250316-preset_v6-v8-2-0703a78cb355@oss.qualcomm.com>
 <gl2klkvpkb2vrxrzdqbqjomfis66tldy6witvbqdd2ig3st3rw@jstguoejcofa>
 <7a0724ad-89a5-0ccd-eba5-ca4871ce1cdd@oss.qualcomm.com>
 <epg6mtsnemzwnqvsze7zbkehovxvu6fpmw52kzfrjmjahadg66@k4gprl4zg5b3>
 <bc8cbbfd-b96f-21b6-6c6d-dd1b97f16035@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc8cbbfd-b96f-21b6-6c6d-dd1b97f16035@oss.qualcomm.com>

On Fri, Mar 28, 2025 at 12:22:23PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 3/28/2025 12:13 PM, Manivannan Sadhasivam wrote:
> > On Fri, Mar 28, 2025 at 10:54:25AM +0530, Krishna Chaitanya Chundru wrote:
> > > 
> > > 
> > > On 3/28/2025 10:09 AM, Manivannan Sadhasivam wrote:
> > > > On Sun, Mar 16, 2025 at 09:39:02AM +0530, Krishna Chaitanya Chundru wrote:
> > > > > PCIe equalization presets are predefined settings used to optimize
> > > > > signal integrity by compensating for signal loss and distortion in
> > > > > high-speed data transmission.
> > > > > 
> > > > > As per PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4 for data rates
> > > > > of 8.0 GT/s, 16.0 GT/s, 32.0 GT/s, and 64.0 GT/s, there is a way to
> > > > > configure lane equalization presets for each lane to enhance the PCIe
> > > > > link reliability. Each preset value represents a different combination
> > > > > of pre-shoot and de-emphasis values. For each data rate, different
> > > > > registers are defined: for 8.0 GT/s, registers are defined in section
> > > > > 7.7.3.4; for 16.0 GT/s, in section 7.7.5.9, etc. The 8.0 GT/s rate has
> > > > > an extra receiver preset hint, requiring 16 bits per lane, while the
> > > > > remaining data rates use 8 bits per lane.
> > > > > 
> > > > > Based on the number of lanes and the supported data rate,
> > > > > of_pci_get_equalization_presets() reads the device tree property and
> > > > > stores in the presets structure.
> > > > > 
> > > > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > > > ---
> > > > >    drivers/pci/of.c  | 44 ++++++++++++++++++++++++++++++++++++++++++++
> > > > >    drivers/pci/pci.h | 32 +++++++++++++++++++++++++++++++-
> > > > >    2 files changed, 75 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > > > index 7a806f5c0d20..18691483e108 100644
> > > > > --- a/drivers/pci/of.c
> > > > > +++ b/drivers/pci/of.c
> > > > > @@ -851,3 +851,47 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
> > > > >    	return slot_power_limit_mw;
> > > > >    }
> > > > >    EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
> > > > > +
> > > > > +/**
> > > > > + * of_pci_get_equalization_presets - Parses the "eq-presets-Ngts" property.
> > > > > + *
> > > > > + * @dev: Device containing the properties.
> > > > > + * @presets: Pointer to store the parsed data.
> > > > > + * @num_lanes: Maximum number of lanes supported.
> > > > > + *
> > > > > + * If the property is present, read and store the data in the @presets structure.
> > > > > + * Else, assign a default value of PCI_EQ_RESV.
> > > > > + *
> > > > > + * Return: 0 if the property is not available or successfully parsed else
> > > > > + * errno otherwise.
> > > > > + */
> > > > > +int of_pci_get_equalization_presets(struct device *dev,
> > > > > +				    struct pci_eq_presets *presets,
> > > > > +				    int num_lanes)
> > > > > +{
> > > > > +	char name[20];
> > > > > +	int ret;
> > > > > +
> > > > > +	presets->eq_presets_8gts[0] = PCI_EQ_RESV;
> > > > > +	ret = of_property_read_u16_array(dev->of_node, "eq-presets-8gts",
> > > > > +					 presets->eq_presets_8gts, num_lanes);
> > > > > +	if (ret && ret != -EINVAL) {
> > > > > +		dev_err(dev, "Error reading eq-presets-8gts :%d\n", ret);
> > > > 
> > > > 'Error reading eq-presets-8gts: %d'
> > > > 
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	for (int i = 0; i < EQ_PRESET_TYPE_MAX - 1; i++) {
> > > > > +		presets->eq_presets_Ngts[i][0] = PCI_EQ_RESV;
> > > > > +		snprintf(name, sizeof(name), "eq-presets-%dgts", 8 << (i + 1));
> > > > > +		ret = of_property_read_u8_array(dev->of_node, name,
> > > > > +						presets->eq_presets_Ngts[i],
> > > > > +						num_lanes);
> > > > > +		if (ret && ret != -EINVAL) {
> > > > > +			dev_err(dev, "Error reading %s :%d\n", name, ret);
> > > > 
> > > > 'Error reading %s: %d'
> > > > 
> > > > > +			return ret;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
> > > > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > > > index 01e51db8d285..78c9cc0ad8fa 100644
> > > > > --- a/drivers/pci/pci.h
> > > > > +++ b/drivers/pci/pci.h
> > > > > @@ -9,6 +9,8 @@ struct pcie_tlp_log;
> > > > >    /* Number of possible devfns: 0.0 to 1f.7 inclusive */
> > > > >    #define MAX_NR_DEVFNS 256
> > > > > +#define MAX_NR_LANES 16
> > > > 
> > > > Why did you limit to 16?
> > > > 
> > > As per PCIe spec we support maximum of 16 lanes only right
> > > 
> > 
> > No. PCIe spec defines Max Link Width up to 32 lanes. Though, we have only seen
> > 16 lanes used widely. This field should correspond to 'Maximum Link Width' value
> > in the Link Capabilities Register.
> > 
> As per spec 6.0.1 section 7.5.3.6 Link Capabilities Register max link
> width is x16 only.
> 

Interesting! I referred the 5.0 spec and it mentions x32 and they seem to have
removed it in 6.0. So I guess we should go with the latest spec (I hope it stays
the same at 7.0 also).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

