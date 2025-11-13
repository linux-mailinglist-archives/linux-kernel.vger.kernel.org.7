Return-Path: <linux-kernel+bounces-899298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E447EC574E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED433B4A48
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E397734DB63;
	Thu, 13 Nov 2025 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPYFMjtm"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A3333892C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035155; cv=none; b=ViQvPR+k/rHfGXdwptJ+aFKGJSZh07rdGIjCkelTR/rqbMbqQdBLwXMVIN8vRmAdSDUjebLlfhkzqq9hxoLr0s7OdspONEgJETlhmntHT9Nq2wbPw/wiWPCptDK2MQMDlG+kiCjZexVq7WfFV8SW+Pz25vS6upMO3Q7vwnFd3CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035155; c=relaxed/simple;
	bh=piE+R+DODWYPPHjD0pGzhLNR2aaWjsMLKfoosxwGZms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DROOg80Fi0Vd/+6IkGV/Jd7JAIIFezB4YKv0ugrnLFXyL87V4mfViXYwwF0EvFAtfLKq9iRPpGmxVyvcltoRxcPLg/FfzTm8547SDyC2Nf4xcV0WKZlQWZzazM9s2pdA1z+PtO6Udb7Yi9GT92jIsx17+TF4Q9tw2S5FcuVcieM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPYFMjtm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297ec8a6418so900605ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763035153; x=1763639953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piE+R+DODWYPPHjD0pGzhLNR2aaWjsMLKfoosxwGZms=;
        b=MPYFMjtmF2zkT0JL/WICrah/g+d8C+cKznJ66MxhUhaBBUiSMf6DC1Y88EcTRxtspz
         cbMBPw/uaiLcz24gGy/6bvfyWDU5aUVolf2m/PweSY11CDUCsPp/togxhuJQRSxw+xiO
         RQjRksYhbY8vUaNqyjkRhW/+pZhXQD9CvpkTjuRIT3YA7nVfXS/CgLifvXWUcA62Lrjd
         4lYrSveMLAsuMdRtrfwm3DoeelFF1cBtOhpKspqAStpqhN4FL8g1WpDRm6LFG02SHksM
         6E1baFBn8jKFnmINNVyG91yaJMfLnxezi5rs0wxBljPSYomsZQAtFFYIqMOccGmm+XT6
         eKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763035153; x=1763639953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=piE+R+DODWYPPHjD0pGzhLNR2aaWjsMLKfoosxwGZms=;
        b=XJ0EYh+9rkTyIUQOaraKVlOx9meWZwWlwxkfifPK1zc/5Ut7h7EzBFCfLTGhC6tQTF
         cIL2VEKWWNCHbqJMT6K6Z8xblDhTa7cMRLX+kCU/vowL9BUa8PvOmX3bYRfjy3mlM8DL
         lKmBYJjiOKwKaFkCosHnH+VlDo5wj+gwbx9U+9lLD7QVERIPMycYqa7q67yPc4SqLw77
         O//EHlaa4wXJUTAQ4XOsKIs+QrOveotZUV/lcdHhLoAUcgiKgW/gLgiwbk9zBTJYDpnx
         MLKSrYtYwfaeRCtAvBAx5yYWFJQCWaBeFcKZkLFpt+VZ6GOyoOPpFdllANTtZyWnepAe
         9QRw==
X-Forwarded-Encrypted: i=1; AJvYcCX8kaoOga8fw0TaGUVwo9X5U2lB8GW9hY0SBROrc11xuM2U/ySgbiK6b/zhX2u9BTw72Wp7jEKqEclN4v4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAz8BnRep19T0A/S7DRSdc++b2vBzP9999Il5JHdfP5oWGa97G
	jP/1YhC+l8YSc5AKY9huTKF1FJyGfnKNyvNCFEM5tNBPzZZ56OGzhBD+FbBQS4NTqyP+uIiGaQp
	hLjrNaNOlaloiTpuMus+8VRUEQp+uC+Y=
X-Gm-Gg: ASbGncsaAKlpaDrolKgZ0Tx1vnC3dOugDUsVAVVjT9sZ9StnozNJQUAZBDeiRs8+d/M
	qOsJ2HYQZecKrgIHwkslyp1P7xoVc9MW6+hQX+Eiko5AriRj8Gaggh4+m7iGX49tg6lY5s6Fs/4
	8dnQdShZlOLdT4hddcUFoVd/W31U0DiL7Pdcv+ZYrodrtv9kzCuruvMpmrhTOlkhyUhuZtZIDUt
	qhCSTSjIpxRhnsCvxzHP6VgjbcR6FaQj72/Ro78BqbycKUlXulFl3E2DM1D8Az4ImBx4em8L4lt
	pncFNvfqxHuJMaKTezlebgucSwK9Vlmk/AEyLX1mfdwtDeaBeewZVktOFv0fCQfSqOyP2M/Yqvs
	hbG4=
X-Google-Smtp-Source: AGHT+IH+D8mikItI/8Y6u4gUIPrRb5tLtmrJuENgrbMSvZ0tfOZVAyP/NCtfZ76q8QGb2mFA/ILYSlBWkwz9/2ETygU=
X-Received: by 2002:a17:902:e80d:b0:297:f2a0:fad6 with SMTP id
 d9443c01a7336-2984ee1bademr45282445ad.9.1763035153039; Thu, 13 Nov 2025
 03:59:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-create-workqueue-v2-0-8b45277119bc@google.com>
 <20251113-create-workqueue-v2-1-8b45277119bc@google.com> <CANiq72k1VqR7P7tY2V_siBQZrNXf_ck5aBkapo6M_6X=1P+nDA@mail.gmail.com>
 <CAH5fLgixPsBwqFdY-ku3AtGQHY+qa9m5oqMUshqdob7nzGQpag@mail.gmail.com>
In-Reply-To: <CAH5fLgixPsBwqFdY-ku3AtGQHY+qa9m5oqMUshqdob7nzGQpag@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Nov 2025 12:58:58 +0100
X-Gm-Features: AWmQ_bkW9VeZXUswN2jzNBepz02JOobTrhcASJoPSgwdewJn2LinH9hrzYbmObg
Message-ID: <CANiq72kamBPnWFg0nBCe4_mcmd66vW86ryiQnV_mTsnemxmjow@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: workqueue: restrict delayed work to global wqs
To: Alice Ryhl <aliceryhl@google.com>
Cc: Tejun Heo <tj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	John Hubbard <jhubbard@nvidia.com>, Philipp Stanner <phasta@kernel.org>, 
	Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 11:08=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> I could go either way. Without the next patch, there's no way to use a
> non-global workqueue. But probably is useful to backport anyway and
> there's certainly no harm.

Yeah, I would say then let's propose it for stable to be safe than
sorry in case this gets missed later on (or someone else out there
uses only the other one etc.).

Cc: stable@vger.kernel.org
Fixes: 7c098cd5eaae ("workqueue: rust: add delayed work items")

Thanks!

Cheers,
Miguel

