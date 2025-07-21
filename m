Return-Path: <linux-kernel+bounces-739309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21057B0C4AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE113B03A4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949A52D8399;
	Mon, 21 Jul 2025 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDTecz/W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6816C2D12F5
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102926; cv=none; b=Idb0zrOlubIb4P6wRRTfENRyUI3302Jtf6xON8CTmC6hn1gOhwWg+5xCgCSh39ynxT+sDCgv0FjkFzuqHUezHoSxc3LANKKAhNHlE3SVS9VUmzLr9lRsYnxbto/0R7X/EqVTzCUa+bSSjJndFk8nacjckm3uRGYAurL9C2TkohQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102926; c=relaxed/simple;
	bh=Kzos49b0GCpostbFROvtYjPTZ0s6iSc5xRDaELxBu94=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fHROxs2NCofJdnvSLNmae/qFcLmWP6WYqwswj01ux1giCc1HY3hwCmSipwx9h0nkc8gUTrFhjSAoSogbMR0gR0ZT1VJJQVRzvemJ9y898KxMo7eCA7MxWnSZwSnivEMUs/L0ODu9gz6AFwyprSupHKxd3emhwOax5BX/fj7Aul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDTecz/W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753102923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jD+wnTaKP0Y8e6Enf/no2sGgqHNYlggzCKTqQZCB61Y=;
	b=WDTecz/WJMXB58R8vIlkwRQrX5tgPU0hLQNHq8XgWpCfVltfPULm+q/QM0R2te8nXeYERf
	iEaAMDdX/byA0IOjC7tf8ZkEsj8bLeY1uA4NAvMs3L9BCsq5fuBQZ0BFxFw3RptyluFrhV
	PFcOMRQWrXd+U9xp5pAG4DvYc7hAm1g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-hGhP_uytN3KY0dlVW2fV7w-1; Mon, 21 Jul 2025 09:02:00 -0400
X-MC-Unique: hGhP_uytN3KY0dlVW2fV7w-1
X-Mimecast-MFC-AGG-ID: hGhP_uytN3KY0dlVW2fV7w_1753102919
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45624f0be48so24279935e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102919; x=1753707719;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jD+wnTaKP0Y8e6Enf/no2sGgqHNYlggzCKTqQZCB61Y=;
        b=GWrqSTw3iib/tPfSQbpdQ/PW9R/0ZkfplD+4FWe6j+xRXOOIgy9/Q9u+3U1AEpk1Dw
         hjBkvuxSyBctLj7UZkyGtX6g6DG5me1Rwqg0VZV8Bi6zsaeKHri/J//2WTQW4zjOwdR4
         M+/UVgVceoVHFpZKBLlYLwH16V1uv1q1JlhWkvUwe9QrVuu+ZQm48Ynd3u2GneXp+V24
         qqC5v+DhiLcUOdKF8B4syVWnYvlQrMIz9BJzAhNg9EDG/VaeIjFbA64I2btKW6ed7NT9
         p6W5HHWbhhEg3oE0BH+8JOlh9zmTrvMYVo4ZqL3hT337x2WSTPes2LBhh76vDyQxHHSi
         kkdw==
X-Forwarded-Encrypted: i=1; AJvYcCVQxLyJXZxbuRJypxx4A4hSptpeznenDuQvuFXwhqR/z65/uPN+9PVMSHHhoSMx6uxvq2J1lBfyloWX+sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUEBkkypNzZS9oN24QwVCJ723pVqAvca0yeyFTukSeV/ZSIQZR
	7vAb6cPMaccHPAwWsVxVRxUO61in7o7xkK7ZA9IIG9RbaYUq3Jcrrx0Tv0nUhMeBsJEv9f9H0Rx
	3E2kSYyBWzFS0Rg/zowmsCzaczVUdM6sM9LGnhJTVkd7n/3VBbBVLJLbI5CWBlykMeQ==
X-Gm-Gg: ASbGnctmXM0tVGK5RqfTxmNNQ+RsT/DNqH2z07KieiFWQXiiUuSZpXzoyFddi0tw5H4
	jiJ0hlChY2OFTJsg7wytdkfGhnAtocJOvYI/yfWYKZJxqk2DM5oFSQqlaML70FHOL2rCKEcOral
	ufxHDX0iT+jdVSDV8m8X26fSy9/tTrswZiI0lTYcO7cM1Uqc+0ADZjbL2YGoPRJheStGWGJ/SQr
	xGS3neP32/ESqjrGBd5aoFTvQ/GUHejiT5vDdcZlovbkLmRvzNGl0zwqIiA9jmjPsJSJZXkFAMR
	VUVuDEQa8o3VAQqpW8niN4GvRdQUVpfCBhUpKULDacCWI9nqzgI/LFhlAvFSGl1wQw==
X-Received: by 2002:a05:600c:310d:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-4562e2a59a6mr217518625e9.31.1753102918077;
        Mon, 21 Jul 2025 06:01:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz92oHW6cf5bePbFRUQ/bTAGdOdmnzzYqC+rPHlpMjNIHtv87b65EeqIpUOgFuaRe0qdZRrg==
X-Received: by 2002:a05:600c:310d:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-4562e2a59a6mr217517285e9.31.1753102917018;
        Mon, 21 Jul 2025 06:01:57 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886286sm163348015e9.26.2025.07.21.06.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:01:56 -0700 (PDT)
Message-ID: <ea84a5ea39092432804bc7c63596892fb9fdf511.camel@redhat.com>
Subject: Re: [PATCH 1/6] rv: Remove unused field in struct rv_monitor_def
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 15:01:54 +0200
In-Reply-To: <68e223323b11aad9934344ec1764337b2f18c080.1753091084.git.namcao@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
	 <68e223323b11aad9934344ec1764337b2f18c080.1753091084.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-21 at 11:47 +0200, Nam Cao wrote:
> rv_monitor_def::task_monitor is not used. Delete it.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

> ---
> =C2=A0kernel/trace/rv/rv.h | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
> index 98fca0a1adbc..873364094402 100644
> --- a/kernel/trace/rv/rv.h
> +++ b/kernel/trace/rv/rv.h
> @@ -41,7 +41,6 @@ struct rv_monitor_def {
> =C2=A0	struct rv_reactor_def	*rdef;
> =C2=A0	bool			reacting;
> =C2=A0#endif
> -	bool			task_monitor;
> =C2=A0};
> =C2=A0
> =C2=A0struct dentry *get_monitors_root(void);


