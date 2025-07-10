Return-Path: <linux-kernel+bounces-725624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F63B001A1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A1E5A08A7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458A02566E2;
	Thu, 10 Jul 2025 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="h4y9XAzU"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A038B25523C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150334; cv=none; b=FK2owCbup6UwW1YIYwmvSszFSgEN+uhUGhHzBbBEKUowhLvI+G+8HzmZZrnCGoslGXXNsc1Qs50OXTXHQOghGZ4hHIUmmznzMO0Xb0AG/2dqK8+JtLgo6C8U80j+neQMTojPI/6LFaPvTDCrCD9l8zEYoa2veoJRi+L6NDcf/XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150334; c=relaxed/simple;
	bh=tXi+3udgGBPcB1usSt++Ta3sqSt9dsDiajyFn9u+th8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=AWbpzBpgC9e2odJ8EeVD6chd0L+FRbPv1BhA2eez9j/ahCYW5+JoY/yA5CAMCicEDjEGXKv4Yb/U1m+85B/ly39iCcz41bzEmAZgF+LagdwJOZKa5TXEaP9JkucBHIUr7k8jkEjRfqcIVmEyhtGG2xt9xz5jcBoabQA+UcZlZzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=h4y9XAzU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso181962066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752150331; x=1752755131; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xwbim7kMT0dZOrtg1YvEDqv9pTaWeBwXvEocCP4T4Us=;
        b=h4y9XAzUlMrVAxtYT67ddWP9ZrYnX8dph0zK5U2Yx9j6OsvLjVr2eRqZyWB+zZhqNf
         LL27iWm7JNub+X5pS97wxAeuphaFpX3+3tPRfSJIsLx5DGb79jIMmuI1utZPF+dnAu3K
         BHSWABLsIe6idQWsdyzMKXJO5x6yuwsOILuE03MZb7SsExndYfmw6y31hE2ceSh44o8C
         htBuOGOdYC4CAwAXpG+4zC3FucpD+hegDYDFxrMsjYaWpFdhnpwLNd6zDeOgoOzL5ZKV
         ZOHIIkEhdUg8rjfkj769g/ddK4huRso/+0N+KUfDhNLlkFR9Q7QLoGSFjt4xhcgRDFhP
         06tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752150331; x=1752755131;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xwbim7kMT0dZOrtg1YvEDqv9pTaWeBwXvEocCP4T4Us=;
        b=ub1I+dn+GN/BOafz6WjjD8IqtGVL8iQULFDfyC1NhpHW5Fb4UxhkK5vWJcshk8fDLK
         zSu5aHY/j7ga4U5ADSr4jAEg1/S/ZoP4e/5o/1OpO0zFfDSRm32g7lusR0J7upq2QSLK
         CLHK0OaXdMag/cgHf/7dTOZycgZ8LdDzBRB5/srRzwioCmvVGyghYWB+TNEhnW88rpV6
         HBTtxPxHxZf28V0K8daE+5yChW+FwEcXUUqs+dfXnlnwHD97PR7+WoW4gEMzYuTk00lv
         +OnghAgdtEiZUlyRPPxBngAi9XvwkelyyHhaKMg4r7TIqAegxtCOonVnOq/OCkO3T/zj
         5Xdw==
X-Forwarded-Encrypted: i=1; AJvYcCU24q/S5DWSkAl4BWi0DqJD3eryGl/HG7DpfdSibN9Z08Uje+zbasu05ypULF23ZWhluL19KTJZUWC+kZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEronSsO6ou2FFYMPLYOdAe3ClcwtrkcJj7LD8JWf/1Tp/zgQK
	A8gPcqaOGrp19jeM+cdGziAzO5o7ZImqR53B/C79MuEZxcpK03jltFilZa24UpB42F0=
X-Gm-Gg: ASbGncun5pKwl+2BdbD70tnAi9LdLwZ7LVha1VY7ypKm7rNpO4ikGMomGyfl1sLmLeu
	H32KTyWdBXDIzqs6koxm9k4OeXX8P4fcK5Lq7Qu/JVkF8aKos9eDdeLpbqtlE1NnDrdW9Begwgz
	W9xVcEtPenrhTiGHTJd2VTVLSrG7TKzuoMZISj/lrqMa9qKbJyreNjr4///cYP5cd6vVHzDxFe/
	ZX/iIj8q1czplYsuxK68ZTiiDmu0RGefs7L1LPdGoVEIKccKy4/lkNgxqi9EX+0lclYsVasnqfu
	Uj6X+8UgR81MIw53OGQXmEgcS582uLyE4MqS1tp0GRlCUGiCLHXuXU8BECRRdOGE+5LYdOeuUDk
	kDIo5nNwlBA+n9mzZY3+rI01jzPer9SA=
X-Google-Smtp-Source: AGHT+IHgPoXaBYMtzbuGf92TYy9uG1SRxa3TcJ8k4yFuiO+mhGC+1G7Z5mU03G7kTXV1yim8ZigM1Q==
X-Received: by 2002:a17:907:ea6:b0:ae4:85d:76fc with SMTP id a640c23a62f3a-ae6e70372a6mr247071066b.30.1752150330835;
        Thu, 10 Jul 2025 05:25:30 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e826461esm122729266b.100.2025.07.10.05.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 05:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 14:25:29 +0200
Message-Id: <DB8DGDEN23D2.1GFB8XI0P3YLR@fairphone.com>
Subject: Re: [PATCH v2 4/4] phy: qcom: phy-qcom-snps-eusb2: Add extra
 register write for Milos
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Wesley Cheng" <quic_wcheng@quicinc.com>, "Vinod Koul" <vkoul@kernel.org>,
 "Kishon Vijay Abraham I" <kishon@kernel.org>, "Abel Vesa"
 <abel.vesa@linaro.org>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-phy@lists.infradead.org>, "Neil Armstrong"
 <neil.armstrong@linaro.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250709-sm7635-eusb-phy-v2-0-4790eeee7ae0@fairphone.com>
 <20250709-sm7635-eusb-phy-v2-4-4790eeee7ae0@fairphone.com>
 <7d073433-f254-4d75-a68b-d184f900294a@oss.qualcomm.com>
In-Reply-To: <7d073433-f254-4d75-a68b-d184f900294a@oss.qualcomm.com>

On Thu Jul 10, 2025 at 2:10 PM CEST, Konrad Dybcio wrote:
> On 7/9/25 11:18 AM, Luca Weiss wrote:
>> As per the downstream devicetree for Milos, add a register write for
>> QCOM_USB_PHY_CFG_CTRL_1 as per the "eUSB2 HPG version 1.0.2 update".
>>=20
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>> The downstream driver supports an arbitrary extra init sequence via
>> qcom,param-override-seq.
>>=20
>> volcano-usb.dtsi has the following which is implemented in this patch:
>>=20
>>     /* eUSB2 HPG version 1.0.2 update */
>>     qcom,param-override-seq =3D
>>             <0x00 0x58>;
>> ---
>>  drivers/phy/phy-snps-eusb2.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>=20
>> diff --git a/drivers/phy/phy-snps-eusb2.c b/drivers/phy/phy-snps-eusb2.c
>> index e232b8b4d29100b8fee9e913e2124788af09f2aa..87fc086424ba4d9fb3ce870a=
a7f7971a51d4a567 100644
>> --- a/drivers/phy/phy-snps-eusb2.c
>> +++ b/drivers/phy/phy-snps-eusb2.c
>> @@ -420,6 +420,12 @@ static int qcom_snps_eusb2_hsphy_init(struct phy *p=
)
>>  	/* set default parameters */
>>  	qcom_eusb2_default_parameters(phy);
>> =20
>> +	if (of_device_is_compatible(p->dev.of_node, "qcom,milos-snps-eusb2-phy=
")) {
>> +		/* eUSB2 HPG version 1.0.2 update */
>> +		writel_relaxed(0x0, phy->base + QCOM_USB_PHY_CFG_CTRL_1);
>> +		readl_relaxed(phy->base + QCOM_USB_PHY_CFG_CTRL_1);
>
> Said HPG asks to clear bits [7:1] on all targets

Okay, so make this unconditional and only update those bits instead of
writing the full register?

Keep the write at this location, or move the code somewhere else in the
function?

Regards
Luca

>
> Konrad


