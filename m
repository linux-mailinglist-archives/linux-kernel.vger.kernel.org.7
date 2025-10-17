Return-Path: <linux-kernel+bounces-857627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C327BE74AB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A985D5037FE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF202D3A60;
	Fri, 17 Oct 2025 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zl2YTDpy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E9826F44C
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691014; cv=none; b=o3Omais2Spf2I5WNrpw7EPZQpgB6/FeH2dKzxUD+m1sVJD176tnmFFDTwMC86cCy4HwBg6/Pv6LnK97s1Neu6ULrB5+csnUvaFIL0ZVa0gl073RRnPAbCwLYA0iJXF7w/5iozJ+dZUzYh5AQd6p4M6IxBNxR9WH+vGRi+dauPGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691014; c=relaxed/simple;
	bh=YYPBQlX7Etpjm7s7QEscaxhTtIcXv6bNblJxH9enR0o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OCfM5rERdEAVsXVmGFjFQA2E1/Kbiaw8XTMmuliKZ2n7aHhgJwX59pFNPNqDvwYiSXS2r5ohmYby8L22J4v7poSd+GXbjVVYHfwbB7t2NmrtYQ52mkd03AgAvjFFAgr75fJ0EdN8eBRmdaMIiS9W/KI9ymg5z0bIuYYgDfeAWe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zl2YTDpy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760691011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zV6AtvlPKGZafx/Nitbtxi83/9doZbaW2tevNb4ppcA=;
	b=Zl2YTDpyjE+qi7yxiZFdlwDdGb5Iw7kLSBvLLXoSl0wUO5p2KNcO0RR7yDR7d8MBLy6tP8
	/Y0NLMH8cC8Ix+8AIyqShWzTWY0wkLieybzY3inA7CwFp+WabBZsx3v/nYYMrVdycCBC3W
	aR2GFm8YXHOmGPGjLKit33kGGlXfZkE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235--X9nFsIxODyORBd6zhOckg-1; Fri, 17 Oct 2025 04:50:09 -0400
X-MC-Unique: -X9nFsIxODyORBd6zhOckg-1
X-Mimecast-MFC-AGG-ID: -X9nFsIxODyORBd6zhOckg_1760691008
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42705afbf19so341533f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691008; x=1761295808;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zV6AtvlPKGZafx/Nitbtxi83/9doZbaW2tevNb4ppcA=;
        b=OaLGxQw8MmApMk2zaBlSHmXxnZOMklDla4KuJXgep16Z594gH2f59wioQJcCiq6ZrL
         cexW2HU5X/JrV1S6Cm/cWa70pmTTrGKeX3S8X5vKfAzmmIgiYwlDO/AAWHi/YQVoBPwX
         VrHGcsmGyvrTtMshDmUEgfTAIWNB8Bw8mjSkD0mikuM8+PvQBwY+GlX4s7kuCY+D1d5L
         r1py58tJU3M17Bc3MJPw39zgOv6jHsmxIcB+MlseXF9K7KdVu6ojoh+tsBhXwr+CV0zd
         Mv8l+izR9hlHnqunil+2aKYy6U4bfnfIdsy4LGbbzshhHMRM0WZdnwg0KakIVlkqUZ7b
         6gQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQtENkBzb0xoEyakPIrdpjbV94gnLgjq8DFomxLZOQww8rDQ1V04/K/qV3SaMTS9Bim2KuL05d05duUxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsIHuiOctvF36K3Js1U0OltwZUy8hEd6oYk4bAFVkpq3Ywi71i
	unCXJFwM001StZvTZhvOsiK5QZeDpZgkyGIafHka+V9/gSVs8t2RcCYANVJ4P8nybOn2GTwZJG0
	eQHPBGdhpN9Ch9bF+6322YbiMAU1RXG06TQxipVDoUd7wV+4TaM/4r6enF5DVhwhPHQ==
X-Gm-Gg: ASbGncuT5r9YodxTkpcAPn/TPtd224iodAnenksmjKkQq98ZeeekVh5afUnLiFdX14k
	4FYlHvW364j4M/fsTqG+dU8IjUetHqrGCdNjCp8NnKzWZr7eGIky9JIhsHeBN4Y+4RviHZcp377
	mwOKLGI27KneoHpVMcTD+iGqgfx/a4qm19piTiwjBoiOKldmaWt1CQScNG5Lv0GBPKbmRH3yh1l
	jWYWyuhr0SEtPCEw0U8Rw1gQPUaqLLfTFsTGxmd1ujNVg+8PtB1ljpQcmszHqJzsY3MPR04uaoN
	U5K2PDNloP0m/krTyFQjHSuPTr9N/RpLqAqe7tXPx/9T4if1B7NRb/GFIry7FwRmPvIwwRPpdHw
	ZDBsPqoL0Hku+RVakMhykquVN
X-Received: by 2002:a05:6000:1a86:b0:407:d776:4434 with SMTP id ffacd0b85a97d-426fb9b5505mr4848407f8f.30.1760691008299;
        Fri, 17 Oct 2025 01:50:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPn1Bq51EEjEp3mbuDuZJdQmHmvxSk92khzwK9w79un3eDQHfNQFRXeoDtb5mSWq1kC9Os9Q==
X-Received: by 2002:a05:6000:1a86:b0:407:d776:4434 with SMTP id ffacd0b85a97d-426fb9b5505mr4848383f8f.30.1760691007930;
        Fri, 17 Oct 2025 01:50:07 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe4esm38047624f8f.26.2025.10.17.01.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:50:07 -0700 (PDT)
Message-ID: <c6b17fa02a82c61a64abaf6c0abb5154f79c4fbf.camel@redhat.com>
Subject: Re: [PATCH 0/2] selftests/verification: Add initial RV tests
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, John Kacur <jkacur@redhat.com>, 
 Waylon Cude <wcude@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 17 Oct 2025 10:50:06 +0200
In-Reply-To: <87o6q6vuyj.fsf@yellow.woof>
References: <20250926094613.34030-1-gmonaco@redhat.com>
	 <87o6q6vuyj.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-17 at 09:38 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Add a series of tests to validate the RV tracefs API and basic
> > functionality.
>=20
> Thanks for the writing this test. My bash knowledge is not great, and
> I'm not familiar with the existing ftrace test, so I am not able to
> review all the details. But looks good as far as I can tell:
>=20
> Acked-by: Nam Cao <namcao@linutronix.de>

Thanks for the ack!
I think that's good for now as it's going to go to Steve as a next step any=
way.

I'm going to send a V2 with the following change just to increase the likel=
ihood
of a wwnr reaction and prepare a PR.
I'll keep your ack there unless you explicitly mean otherwise.

Thanks,
Gabriele

diff --git a/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
b/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
index bc0b2668bf7c..5a59432b1d93 100644
--- a/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
+++ b/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
@@ -4,9 +4,10 @@
 # requires: available_reactors wwnr:monitor printk:reactor stress-ng:progr=
am
=20
 load() { # returns true if there was a reaction
-       local lines_before
+       local lines_before num
+       num=3D$((($(nproc) + 1) / 2))
        lines_before=3D$(dmesg | wc -l)
-       stress-ng --cpu-sched 2 --timer 2 -t 5 -q
+       stress-ng --cpu-sched "$num" --timer "$num" -t 5 -q
        dmesg | tail -n $((lines_before + 1)) | grep -q "rv: monitor wwnr d=
oes
not allow event"
 }


