Return-Path: <linux-kernel+bounces-893014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A923BC46552
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628AA3AF8C9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A08E30BB9E;
	Mon, 10 Nov 2025 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="H2bctr2a"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B095030AACB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774905; cv=none; b=ZjZanbHDTod1eOWceX5kmRhMIxxwXa9IPnce5Zw1clvKBU2268m0Xb9ivfEWWgjVR8VZqc5Xk4z0VyyOPzsNRDIq20iBS+Bz8ZEKjI/NhyfgIll1LbP0KKVXtcYu4ERG/jsUfOjOHdo7XRIsFjTUuUxvkVeqvw0UAHuSwbh76LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774905; c=relaxed/simple;
	bh=4evboygHfllG7Usog2TgDkAQtAorhUspDMGXw73Mraw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Y5CoVBS7QofQJPSu7ZIpZKdSeRMdY2kxJlzLpp0BNiuw3AXN/7nMonZTi60bCMW1o+bc0jVWU4jOofrubG6d4en34jE3cQGeUjwjdOn1lAmA71NAuUT0shHJW9+rZ+vDQzLU6/WpWmzXfaRFnALsLHTlI7rmi+5IgsaZ/OD1v/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=H2bctr2a; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47777000dadso10155505e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1762774902; x=1763379702; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSv319ON8s5k79NCoOUYSS4YvjAcOb/v3+cIU8nITNc=;
        b=H2bctr2abnNApyGwXZaxpnLxO8sitS/pjkiy877h2FDVALYcZJe6VFpFT5JevQm2yh
         up7MPJB1IgL0r9938JlykAZQPx0ef4f8KRQ6tHnG+sgR46U49QE4fDZyUw56ynUS+JOn
         kyoSEpd+48UDMWJpOnSNYeTfYfAZ2umZkAREfcCo/eAqRMkhD6A6vEH4MifHgW/anaJV
         kLfrLyD+ADOe2oJy4D1WciBjfvQOgWoR7LRBICyDIMzf7kcBQiBgTXyZo70J6sB9v7gj
         jqj98/yT2ifei5AAraWLqHEBcTJpJX0PTCamRH7Gb7SMIrvlfIWcXA2Al7ZX2aGm4jYC
         WHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762774902; x=1763379702;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WSv319ON8s5k79NCoOUYSS4YvjAcOb/v3+cIU8nITNc=;
        b=RFPLrJ56YP+B3zG16skBdNnW9l5Zfn8Jvzol+xbqiAcKKlLlDQeMM3U3whZXT07C4V
         kWrARhTMpwsl/pWCr0UqhqK3U/P60bRhWZ3ROoQQ1J+6UbbBAUA5CLG3fz9JUL63vp4q
         EoMUt6FjRULZVo9yQ6BZBNEInUbvldytm3DwRqiWeuNA8n/ZAFeWjEb2FdMaAV820TC2
         RVCLuijcinJFPFNWELCRPd94ugaUYvi+YGjJP0zZDAF/RXJ6D+qIo+gKwHtjaCUaovUL
         w4IxkKIpFGFiKjIYP6mkKPY20LvnEHwTAkofdRLzaGC609HfsASTdSx4/g4z/GbOEWWt
         Z8bQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4sVhBJyTsdVd+S5+z7hIp5QTtQeJE/gO0H6gEGzTsphaL27DSjyiMt76xf9Gz71wsZKVd1lySaDMTJ+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2OFptuuRNNVsqU/S0/VTfOo/wK86PjVP2Qpn2MPVocT7oSnv8
	Yc20kKQCxttd66jry7bWDxDnCX/zZPm5DbPsYczrTrqzN0qZuNFKxfLDgNfmWDT6obw=
X-Gm-Gg: ASbGncubg6W3hGc6qkoB9oMAdElxYMeHIZk9aZqeNn9EI2o6F+i9wrXF5ZTR+aNgiwG
	x70qaNtQWrzsBH5kqe5n0PMsix83qhoratQm+HXQmajvKXiWo4fpCgWFJJLtQE9t3rRPRexiLAv
	cUCFAnorsFMSgUAOkxsLkD0a2Z2vgJBe1/yiw7yVsN7hii2AfJIp1BAjbYRVNpYamDEt8lO0DHJ
	hTqnZmtJ8GfskCdCgznQN2zUMIbuaRvjlxtRHrltTmXIDF361AX+ux97DxVBl1w/vLjc3d9hz6J
	i9nencYOXZvoOxjhNk/vuKDM5fT64DcD8jIYuZm6nuaJqlfVGFXA9+KjPr0vtEI4ifqlQnhg9xQ
	eLC/MnmsTbyF+ExLAVtze7VFGH+s6vVCB3d3c4tbma/aTRQBTlZlhfQexfmP5Q72vS0WM23695m
	P6ICSqKV4id5Yh+DnSZ9xlK2lIpgHzSXHAswOtFurpcM2CkrhFu48xaFTZHw==
X-Google-Smtp-Source: AGHT+IHgURZ+2ALbsYAeFytpaGuY3bxXAOFksVTI2Vrqto3KQB0fcrxUmYbmcgxUCetGDJMVEYFXbw==
X-Received: by 2002:a05:600c:1ca7:b0:46f:b43a:aee1 with SMTP id 5b1f17b1804b1-477732a9d90mr72371385e9.38.1762774902061;
        Mon, 10 Nov 2025 03:41:42 -0800 (PST)
Received: from localhost (84-115-213-210.cable.dynamic.surfer.at. [84.115.213.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bd084d4sm247107225e9.14.2025.11.10.03.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 03:41:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Nov 2025 12:41:39 +0100
Message-Id: <DE4ZJT518WU8.1JNHYKMU3IBAQ@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: <david@ixit.cz>, "Robert Foss" <rfoss@kernel.org>, "Todor Tomov"
 <todor.too@gmail.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
 "Vladimir Zapolskiy" <vladimir.zapolskiy@linaro.org>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, "Luca Weiss" <luca.weiss@fairphone.com>,
 "Petr Hodina" <phodina@protonmail.com>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Dr. Git" <drgitx@gmail.com>
Cc: "Joel Selvaraj" <foss@joelselvaraj.com>, <linux-media@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <phone-devel@vger.kernel.org>
Subject: Re: [PATCH RFC 6/8] media: qcom: camss: csiphy-3ph: Use sdm845
 C-PHY configuration sequence
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251109-qcom-cphy-v1-0-165f7e79b0e1@ixit.cz>
 <20251109-qcom-cphy-v1-6-165f7e79b0e1@ixit.cz>
In-Reply-To: <20251109-qcom-cphy-v1-6-165f7e79b0e1@ixit.cz>

On Sun Nov 9, 2025 at 10:39 AM CET, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
>
> Enable the 3-phase (3PH) lane configuration introduced earlier when
> C-PHY mode is requested on the SDM845 platform. This ensures the proper
> initialization sequence is used for C-PHY operation.
>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/d=
rivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> index c2adbde6b4e0d..03f5c4676e89a 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> @@ -1103,8 +1103,14 @@ static void csiphy_lanes_enable(struct csiphy_devi=
ce *csiphy,
> =20
>  	switch (csiphy->camss->res->version) {
>  	case CAMSS_845:
> -		regs->lane_regs =3D &lane_regs_sdm845[0];
> -		regs->lane_array_size =3D ARRAY_SIZE(lane_regs_sdm845);
> +		if (c->cphy) {
> +			regs->lane_regs =3D &lane_regs_sdm845_3ph[0];
> +			regs->lane_array_size =3D ARRAY_SIZE(lane_regs_sdm845_3ph);
> +
> +		} else {
> +			regs->lane_regs =3D &lane_regs_sdm845[0];
> +			regs->lane_array_size =3D ARRAY_SIZE(lane_regs_sdm845);
> +		}

Why not add this directly in the commit adding the sequence? Otherwise
the other commit adding lane_regs_sdm845_3ph will just have an unused
variable warning until this patch.

I think it's one logical change.

Regards
Luca

>  		break;
>  	case CAMSS_2290:
>  		regs->lane_regs =3D &lane_regs_qcm2290[0];


