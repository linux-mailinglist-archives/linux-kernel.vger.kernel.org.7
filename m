Return-Path: <linux-kernel+bounces-865614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 865B4BFD972
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 480EC4E9CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1262C0282;
	Wed, 22 Oct 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecfNsfd3"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C5284B2E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154243; cv=none; b=D+NI/+CP7Q0ryNVoyDEz3OBGY5MlahgHDQjUpb7fZmYfAxq04lVKuPWGao/id8PHM1GvjeN/V2HQHo5DYSbSdbZmIMx4mSEG6uhw9OwhYXE/VmvwJpfCjlCwbJ+70uR6CP+6i5k4H+t5tyniricnIvJjnWhjQIA/u4p7pQ0aDUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154243; c=relaxed/simple;
	bh=dhyaC0ICk5isf1JAQ07TmGyf/BAWBQbKFRNYZv3i8W0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aj4ex4yiJqGhqQ/y3ENHnICqp3m98kDla+nE242EAoraXQ3Shkxjq3bud53hUA0j3SpsvS08JAFu0TBBDY6aqYcaKSQBGIlikZa/lUmar3iujNsnuPzPn4aAMHCqx0zbyQKrTFdNPyTdpIWv42zMMR7CGcs+EYjw+ukyVFddVbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecfNsfd3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-427091cd4fdso3541068f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761154239; x=1761759039; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1nFCN9pLEfI7dNTPvL0mUSRHrfYXPoZtHDehAzFK4eA=;
        b=ecfNsfd3DHtmTB/E7FuoAZD6acec/9UFub7eFPkwwVmRIefRcdZEyLbOb4vzz374NC
         GUCJ7X4sZCrqtSwCwRv0HDIPa0fd1D7ocmtWx4pxKnlmPuFStO5su4g1uNZ4RGUCYbxa
         MBDkiSuIdsiucYdkEqgOr5fIqojn7DzfPvm6BtANnTz5jcKhx23Xl5Sbi6M9IERHe61T
         xU9SGUP6fFDjf6oTkkRARKRGDQoUk70n73vlZNrwmI7nahiqL+T8pMWK43RnCFaJX8y9
         31cetQVmz3wJMSD+gEmAKJDcZWhsGElRoBVmaGRCGY8Jyfth7lkTvaU+XDDCxGLDcMDe
         m3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154239; x=1761759039;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1nFCN9pLEfI7dNTPvL0mUSRHrfYXPoZtHDehAzFK4eA=;
        b=ul5g7/eFUldFgotV73AnA5FKH82DS027crorq9IrdxTpi4bNUV2SqJ5GbbBfI52g7f
         lsk3Rn6n/9s1L/fPwbbmrr4beAsRZi9fAfYa4E99ucwavFn98trMcxP0dldrxkWhLeTc
         +Hqjb8bOp5ytHhs5x5W2/6TrlLHYYpPlLFjurySIMtm3p49Q+9LJFpUncLxmEGsRXYgm
         d+iwFJP37FisBKdnNVjfFaajYOBNm/sOkZSut2WRFWZ2KCjszQRgxAOdWUzf0TU6JeIf
         prUFb8gIfcuzupTCIXTCnNr5tTQxwAvACVb6oiYPseC6wpGFNNaEeBUd4GY3/eSZhDJc
         dpfg==
X-Forwarded-Encrypted: i=1; AJvYcCUSXgmZRHem1FcNQ9dNuneCk14ukywEQ1BPwQb9/07W4WFdXzq2j2MHK6j0tGueGChEYAq1WYNq/sDefX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI51bBDlskc/Cl0MPlg6QdBl0TwDBYLCg5TpnIQw3uUO1Oe4XP
	JCMkCflvKNBd7+1Oz8IZuvcOfCtCa4/xsiNgl81XlUUSjelFVm9G2qCC
X-Gm-Gg: ASbGncvrtwmx0CPoY/fuBNQ3VqjnwNbGCD6tkU9scSp6omG0dQQU09UKq7oQ657RZe3
	qVb3ctuoh5CEYZg/ntBHjjFsvt8iXMYf3QRkAiNeUAgvYjDxEPFQHnyrTpvjO25oUL1FAi5lqRb
	BoLrvaM3XRhqP8tlbCveN5nTyJc86WQpbvNXhBBdgyYJ595AmtsAuCsQzphxU4Drhv5zcvjKLKr
	/lp/exis3qT7rFD1TQkAj8Xja/zMvAsNbKB/5jt4g0LIPObs2h1yyrb55zPHJBTHb9qaMRNqmPl
	Pd4tY9Rn0T2r975/NO6zHSdMS8gxbggYSGU52kGgH/EANEJMZ8KLkCSo7fUaW1//P5Gvaf7pX2z
	iG4oTB9zo6PURHtyURBP/R0jQcO1tQp9A4WXkGWhzoSFDGNmfFFYiX1WHogt5ye9oiNeTmcZ2Q2
	SDjiPwYqkRhCo75QvHW8lisqLhQfxc3l9oOhMrSk5eHNV9DeSihjxkE5vICg==
X-Google-Smtp-Source: AGHT+IGpzLyeFOtu3WGWo07Zjf+OlCN6M5eusYAHPhvOlsQ5WxNrnoYQLWAS9/q733puojsFm3TO7g==
X-Received: by 2002:adf:e19a:0:b0:427:613:7772 with SMTP id ffacd0b85a97d-42706137842mr12906996f8f.32.1761154239253;
        Wed, 22 Oct 2025 10:30:39 -0700 (PDT)
Received: from ?IPv6:2a02:168:6806:0:5a8f:8582:c21f:f389? ([2a02:168:6806:0:5a8f:8582:c21f:f389])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3c56sm26280266f8f.18.2025.10.22.10.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:30:38 -0700 (PDT)
Message-ID: <68dd3d93509b627dbdf907332a703443f46aff6c.camel@gmail.com>
Subject: Re: [REGRESSION] ath10k fails initialization, bisected to "wifi:
 ath10k: avoid unnecessary wait for service ready message"
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, Jeff Johnson	
 <jeff.johnson@oss.qualcomm.com>, Jeff Johnson <jjohnson@kernel.org>, Kalle
 Valo	 <kvalo@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>, 
	regressions@lists.linux.dev
Date: Wed, 22 Oct 2025 19:30:38 +0200
In-Reply-To: <5466e122-9143-482e-a9ab-7f956e19bf86@oss.qualcomm.com>
References: 
	<20250811-ath10k-avoid-unnecessary-wait-v1-1-db2deb87c39b@oss.qualcomm.com>
	 <175823924851.3217488.17742065327824732992.b4-ty@oss.qualcomm.com>
	 <6d41bc00602c33ffbf68781f563ff2e6c6915a3e.camel@gmail.com>
	 <76d4235d-db4e-40f4-9ede-8cb536b82fbd@oss.qualcomm.com>
	 <10919281648e306fd3f6713437b4793c50bb6692.camel@gmail.com>
	 <5466e122-9143-482e-a9ab-7f956e19bf86@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-5 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-22 at 16:00 +0800, Baochen Qiang wrote:
> Thank you Klaus, can you please try if below diff can fix this regression=
?
>=20
> diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/=
ath/ath10k/ce.c
> index 7bbda46cfd93..1a981d333b5c 100644
> --- a/drivers/net/wireless/ath/ath10k/ce.c
> +++ b/drivers/net/wireless/ath/ath10k/ce.c
> @@ -1256,6 +1256,19 @@ void ath10k_ce_per_engine_service(struct ath10k *a=
r, unsigned int
> ce_id)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(ath10k_ce_per_engine_service);
>=20
> +void ath10k_ce_per_engine_check(struct ath10k *ar, unsigned int ce_id)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ath10k_ce *ce =3D ath10k_ce_=
priv(ar);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ath10k_ce_pipe *ce_state =3D=
 &ce->ce_states[ce_id];
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ce_state->recv_cb)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ce_state->recv_cb(ce_state);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ce_state->send_cb)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ce_state->send_cb(ce_state);
> +}
> +EXPORT_SYMBOL(ath10k_ce_per_engine_check);
> +
> =C2=A0/*
> =C2=A0 * Handler for per-engine interrupts on ALL active CEs.
> =C2=A0 * This is used in cases where the system is sharing a
> diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/=
ath/ath10k/ce.h
> index 27367bd64e95..9923530e51eb 100644
> --- a/drivers/net/wireless/ath/ath10k/ce.h
> +++ b/drivers/net/wireless/ath/ath10k/ce.h
> @@ -255,6 +255,7 @@ int ath10k_ce_cancel_send_next(struct ath10k_ce_pipe =
*ce_state,
> =C2=A0/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DCE Interrup=
t Handlers=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D*/
> =C2=A0void ath10k_ce_per_engine_service_any(struct ath10k *ar);
> =C2=A0void ath10k_ce_per_engine_service(struct ath10k *ar, unsigned int c=
e_id);
> +void ath10k_ce_per_engine_check(struct ath10k *ar, unsigned int ce_id);
> =C2=A0void ath10k_ce_disable_interrupt(struct ath10k *ar, int ce_id);
> =C2=A0void ath10k_ce_disable_interrupts(struct ath10k *ar);
> =C2=A0void ath10k_ce_enable_interrupt(struct ath10k *ar, int ce_id);
> diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless=
/ath/ath10k/pci.c
> index 97b49bf4ad80..ce8e0c2fb975 100644
> --- a/drivers/net/wireless/ath/ath10k/pci.c
> +++ b/drivers/net/wireless/ath/ath10k/pci.c
> @@ -1812,7 +1812,7 @@ void ath10k_pci_hif_send_complete_check(struct ath1=
0k *ar, u8 pipe,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (resources > (ar_pci->attr[pipe].src_nentries >> 1))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ath10k_ce_per_engine_service(ar, pi=
pe);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ath10k_ce_per_engine_check(ar, pipe=
);
> =C2=A0}
>=20
> =C2=A0static void ath10k_pci_rx_retry_sync(struct ath10k *ar)
>=20
>=20

Thanks for looking into this.
I applied that patch on top of current mainline, but unfortunately the resu=
lt is still the same:

[    6.094149] ath10k_pci 0000:02:00.0: pci irq msi oper_irq_mode 2 irq_mod=
e 0 reset_mode 0
[    6.241457] ath10k_pci 0000:02:00.0: qca988x hw2.0 target 0x4100016c chi=
p_id 0x043202ff sub 0000:0000
[    6.241476] ath10k_pci 0000:02:00.0: kconfig debug 0 debugfs 0 tracing 0=
 dfs 1 testmode 0
[    6.242901] ath10k_pci 0000:02:00.0: firmware ver 10.2.4-1.0-00047 api 5=
 features no-p2p,raw-mode,mfp,allows-mesh-bcast crc32 35bd9258
[    6.309202] ath10k_pci 0000:02:00.0: board_file api 1 bmi_id N/A crc32 b=
ebc7c08
[   12.509266] ath10k_pci 0000:02:00.0: wmi unified ready event not receive=
d
[   12.581057] ath10k_pci 0000:02:00.0: could not init core (-110)
[   12.587057] ath10k_pci 0000:02:00.0: could not probe fw (-110)


