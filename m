Return-Path: <linux-kernel+bounces-886644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 316B8C3635C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BEFE62218E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD95B2F28FC;
	Wed,  5 Nov 2025 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXj03Umm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lXSKymJZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE9223504B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354149; cv=none; b=hQn5KVwJEDw/VVhtNVEbEqWgVGtU5nflLHVukq/jWop7V1HMh5x32aVRLZPCwPc5jFu9SfgqfpCJ4PMCDWLel3cu0hZYTO+XPGv6YLDIxy2M21tz8tb+WXcOpcE1Lba5bm4AHl2lsgspa9kL32ZoVN5H4PsOdWjTEV1tsW/GRrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354149; c=relaxed/simple;
	bh=YfvMW72encoRkud0wVtm/A7j2WUacp04L3fsNBayHvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYzdws3HLRfb91AfXWIasl5qtaWCC/gQNUocfu95reQWcLUlJ6MOLJYFLI0PVE54Pxs5KZrH1RpLAmFiaCg64uqbAVPadzogrQtuLbBjAXBihhL2iR9M/1H3kD1T2XQBgjW7SH4mni5YgpRrMpyDdvGCk5k7+y4eLmYUHtS2lV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXj03Umm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lXSKymJZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762354145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43sHUCklMiFn+SiCjLKJSBqe6MedMG8UZiB50DllYfo=;
	b=KXj03Umm5zqC78KHtiI0lrsWdn1xNo2qS0DrCilMNvvmF6ZwBQzN8DzzIJbMkVC6pXGkiy
	d0GYO8T2HoCh4nvWFcgWJ1pNZZ5JsG4iKvVT/OuHwM0h7VRj+BVxZHzYejhkcCt+POyNVQ
	9ZAj5GcpKgBE0zZXy9zQrbrpKnFcpgQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-gJ6vy20dPqiqg7Mo7nYaLg-1; Wed, 05 Nov 2025 09:49:04 -0500
X-MC-Unique: gJ6vy20dPqiqg7Mo7nYaLg-1
X-Mimecast-MFC-AGG-ID: gJ6vy20dPqiqg7Mo7nYaLg_1762354143
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-471001b980eso52916365e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762354143; x=1762958943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=43sHUCklMiFn+SiCjLKJSBqe6MedMG8UZiB50DllYfo=;
        b=lXSKymJZLRal60Vh76tTo85Oz6Ng9PEp/SrkcphQ9kZ7PQyiuc+90rnnuzfn3ne7/I
         W3bc+6sREp9EkKnVgWIqvLfinym7NqMG1SW5b4isQkqah6R4F3w2yarBiutxX9/aeWqw
         M5HuZQmfSN5rwol1BkpVuUJx7F1zLe/9SmHm/prlIoQacB68rzeImmNmKdQFOtYoma7Q
         rnhIMZYmaGD8WdlBGq5g5Qr0jIqwf9dVxhhtX08Fjtv3RRUvGaVuOOLd7nIO9gtVGYw+
         iHtjaHQ+bxMqxSA3vR0YTMRxEovgjgwVtWuR4fzykypPbZEGxykQJhlr7NoZiHP3Nb74
         KwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354143; x=1762958943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43sHUCklMiFn+SiCjLKJSBqe6MedMG8UZiB50DllYfo=;
        b=S4jz4N7+aH6Xx9k+WxF99Bo+F2tR2xONUP/Wc3WHOy2gr8TkJY5vQoVWg6ecE1c94V
         TcJmrLCWYxpcF3F6AsOOc/hezR8d570ETriGLGORvek0sLe3+0hTcziX0uGMBko8I5R7
         Uad8+ft9Agy4qWSNTeFv5QaIVVjOTjhQJaPY35WP4jB3roKUCPg3vQNRaPAjUnp397S6
         a8v9+dToRn7zO4uGrYJULOC+nIfYx2w+wxCjPJYopy+0xMgpjflaUGxnJ1Dt2E8aLiiO
         S5OGxBn5Tloih1nbWxhQLmqOAK9HyjjOpAXzerPymxtH/ru661gKx516ETzr160uX184
         3Xjg==
X-Forwarded-Encrypted: i=1; AJvYcCXZWfkQnRMoXOOodSRLx07EpBnx+f1p36m94WRvD9RlyFvlWzj8weaodZZu9tbej6eoBGA0bbhDdu27ZNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkhTStvst18v9xH3jlWUD5oUTHzNn29ZkwjchoMqvbLRWJYBGz
	toYB+W+oZb7IOtIekawVhRVVLUTmJAl+vFKRku4MjGHInSlVQRtlKtwHR5kIJ+ym/VZmZrvla1x
	o5VO0HDOzACeAyofg/VFBbN4Cm42cqMLbEUHeV6dggcip3zXzw9nWTIV3GOqW8ql04w==
X-Gm-Gg: ASbGncv99/AcGZBruPMIDcLg1v5r6rirbHxujFcCFzRUN8z9IphQb6i6FusfKuvcHwY
	twP3Twy69JEB7724RJf9pr5l5Ap/+aJ+trg+3PG9opK9y+OXxBQR7kvHwXJGmxlF38ALg6cZJp4
	61mSIHaCzHFdzjhCPB5NdZkGXXTcsDtmiJAiKICjyU67dcyZpsu/Y1xC6cCqTgB99RUsg0YTtze
	qlYXPhLojlAcENZWcNe9TjbSyHpnaArIe7jfE3DF8yWs274MN+2fBd6MCaHLT5D0jYaEzsmHNoV
	J4W7/Z55LG0tnFXcaRPnMQ4suiNUDmUvaQJhHcfATTJtj4W9sw9In42CBX4lnPBFf8xUFdEfg+4
	=
X-Received: by 2002:a05:600c:5403:b0:477:3543:3a3b with SMTP id 5b1f17b1804b1-4775cdad69fmr30953875e9.6.1762354143235;
        Wed, 05 Nov 2025 06:49:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJCkXVCaYKB38WQ9mVlW2atyii43mXLtD2rPfe/M0bgqyi++PixdCT104cVwdbGCHZnaBsew==
X-Received: by 2002:a05:600c:5403:b0:477:3543:3a3b with SMTP id 5b1f17b1804b1-4775cdad69fmr30953665e9.6.1762354142802;
        Wed, 05 Nov 2025 06:49:02 -0800 (PST)
Received: from sgarzare-redhat ([5.77.88.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18f41bsm10751085f8f.9.2025.11.05.06.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:49:01 -0800 (PST)
Date: Wed, 5 Nov 2025 15:48:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 11/12] selftests/vsock: add vsock_loopback
 module loading
Message-ID: <ubfxj7koxuztrlrydfpjxenu7sdydq45rnhxkpmuurjfqvyh4j@mwzsqsioqzs5>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-11-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-11-ca2070fd1601@meta.com>

On Tue, Nov 04, 2025 at 02:39:01PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add vsock_loopback module loading to the loopback test so that vmtest.sh
>can be used for kernels built with loopback as a module.
>
>This is not technically a fix as kselftest expects loopback to be
>built-in already (defined in selftests/vsock/config). This is useful
>only for using vmtest.sh outside of kselftest.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 2 ++
> 1 file changed, 2 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 0657973b5067..cfb6b589bcba 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -434,6 +434,8 @@ test_vm_client_host_server() {
> test_vm_loopback() {
> 	local port=60000 # non-forwarded local port
>
>+	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
>+
> 	if ! vm_vsock_test "server" 1 "${port}"; then
> 		return "${KSFT_FAIL}"
> 	fi
>
>-- 
>2.47.3
>


