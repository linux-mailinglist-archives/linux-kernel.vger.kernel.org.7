Return-Path: <linux-kernel+bounces-888790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6D1C3BEA7
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B13434FF7FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AD9311961;
	Thu,  6 Nov 2025 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZTfUjg83"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE071346760
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440865; cv=none; b=n/zc4nbM9WTcma8JQ+IXuSYyQXdcSr7VLlgXzf7soc6jL8xc6YF+Ia8D3VxKA+QAuaG5qcqlrWiN98u7R7HpjXGBE9Fy8VdgwPJXLWjd7kOQvs4HdkpOxciFu3MgcBOOlANt2tE5e6b5qZk1mUoG6grCOnizw2TRs6tWXhOTiQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440865; c=relaxed/simple;
	bh=ozOcgMxD/NRKJQrmMTIroO6F4bQ2Qn4kHa/gDXh91fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6ouV8mVEp0SfCBzZkMazSWKkRvazH+ZkQLwdOsen6HK2APTOyEaq2aOhvdlMqI1d51XM9XnyCc7kj4ZeNbM6xmJ6pw5/6TS/D3Ej0mhGJJqMF9jWK86iXyuOsCPMbHVI10c/1VWSYgMAvHnohEWTkKRKJCAzvaZqrRvh1YABQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZTfUjg83; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9648F3F921
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1762440854;
	bh=AeJV8PctFSZqeTwM/Nu1W1BbU7+ROG2OVp5zv88vYO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=ZTfUjg83/DWLDKivva1BNDL1hm5G4IWJi4/+w4wH9HwJW0yJqd6QNg8H9KvU1EQnB
	 4UinSWiJY54YP62RmKC7ItcoOSu6wpfv30YA7F/qHOiwiDv/KhxL9HEuXaKh4gZV1u
	 MJhH5b9OJxMvXHQsdI5n/1EPPBJ7yT1xm6eJwYyrA964bM76hQEUAXGoP7dJ3tdv8f
	 yuzklWGXJel4rJY59dtK0lRuVIrP8EIzTrsUW/5/c2sbIrZaz7uttXsw3NQAUYAEWf
	 kgATJVCg4QagclMmxP3YMwCgD4/zi2QZ0fQrGebRTRmT9SDZ5uE1r+M1LXd7GKbBXS
	 c5pEkA4wjo+Os6Y+9MiLTFvp637OkwcAy7Z3+Ubem1jM5N93nMsmTHc8UnvOZT1DM5
	 v4K1v0v116ttI/9XVSgAL8RIvxz5CPfyxVoG8/1bCPdPtTRmaJuSE7RYhGq5zSqIAc
	 Ud4lX3AP00RgNsJ6KO9DsAXD4I6aSHONDAsScGlCcj9Lhex4ehuK7VoVvo2SvPzAn+
	 1rmxzXYfiwTp7wtgJzvSyl/ruz9tqpzQH1kQfo9b9u0/coe65tBOg5nZWhvmpE+9ci
	 dh4yx/yw8WFw9vkZs1wfBjcrkqG7ZEsrk9W0gM1Sj34lRawp20NAIdZQKCKKN88joq
	 +/sJksID9gZgiyRX5QllqJEs=
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-592ee3b3eadso444527e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440853; x=1763045653;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeJV8PctFSZqeTwM/Nu1W1BbU7+ROG2OVp5zv88vYO8=;
        b=HMeDPMB1pnojoQK+X5nNiDpMQWiWstLrbQ5JPxrgHOhIshhtU2N8IsvwNVPWxguP4B
         HmVgFTWnVxjv6DVwkOnrtrgK8k6PfGBJgh97BAToJIA9VS3uoNwAnxlzSiD8o00BiDcG
         GyZDVj9oAFcveUbugaD/2j3epaarLCkITVH5ik4VATROYSiDfeN21AdfXwrQsXWbn1kH
         Cc/3WtJQgPZlww1lPuKo5eAu0hSzJHtsMeCbbpGE8iBY2RxmlMUhfG05xIFCvVfo/8+G
         hoggAeQTNKmi3DObUsnudzu3ZPWNv6a3SZQzhhg/RGRARRa3EismA8cVd0vCRgiuOzLc
         ZTLg==
X-Forwarded-Encrypted: i=1; AJvYcCV308yQweazUjKdvTcd9ZblRVpjZEM0Sm9dcl976f/HNkqrbBiHGXq2tlJjTPxWX2l3YTt0+yIn9fmSFE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk3zjje3cD+xjsi3b+geoJKa7LuC72ojrIMo03QkicpJwYQnwF
	3Cdll5x6qnjWqal8oP8qvDHIHYha3S3jWD6Pv6EPT3HqawUztFRjZcKEY9GuDU1kPzTN3z2pSGX
	+9Vn5xzQN7Mgvzo62Amh17TFfPjgct9+3EtoL4HikpWtrmlORHo0ncUKAph6fTVihqwgxqF8uD4
	oEEYGCDeK95A8mn7rylwg=
X-Gm-Gg: ASbGncs78KU6U2UXWCVk96+tOvWVaFpnm4Skpv1YWRD1GvwfeLAuFEwuJHKmKR3CruO
	eEvWQuiBGcV8e3Uv7fWjCbmVnR5e36X/tqPyOQGcuQUik7lUWzrlj9XTcT3Ka6wdvH1o837iFHi
	Aw2qRsxSsPueNj5rS1CqBVLzEHE/GunXqy7x38vz5Oyx1zNVHf5eeKkBfUbfDUKr+HlSMKprl9n
	bMuzG/q2bJV9CPoUS0aIKCQ8nPXZyqcjSmOy+Gwve3B+xrLp8j/fmTHYu/e+JSaPK5y8XsLQ+b+
	pM7ZNqDubi7/R0vkK9ZqjkGwLJEStCEkXo7Qvd30YElzF/IhVPJ4hnXsTonFHRapumtXIwiNA05
	f7zpc6+FWUtWfTc3iIeRblYplYH7loP+LSQ==
X-Received: by 2002:a05:6512:61a1:b0:563:2efc:dea7 with SMTP id 2adb3069b0e04-5943d7c9126mr2591527e87.34.1762440853561;
        Thu, 06 Nov 2025 06:54:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkya0pNrMU6ObtM5yVc6w7wtXddBoJJXH84XUOtreiOgT24KGL2kymBLvJ1zbA5T8rX5+9bg==
X-Received: by 2002:a05:6512:61a1:b0:563:2efc:dea7 with SMTP id 2adb3069b0e04-5943d7c9126mr2591517e87.34.1762440853104;
        Thu, 06 Nov 2025 06:54:13 -0800 (PST)
Received: from [10.207.66.60] ([93.94.208.159])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5944a5a0d0asm758572e87.111.2025.11.06.06.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:54:12 -0800 (PST)
Message-ID: <f169ae3a-d50d-4eb3-a977-bb16270527bd@canonical.com>
Date: Thu, 6 Nov 2025 06:54:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] apparmor: Replace deprecated strcpy in
 d_namespace_path
To: Thorsten Blum <thorsten.blum@linux.dev>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251106145138.2123-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20251106145138.2123-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/25 06:51, Thorsten Blum wrote:
> strcpy() is deprecated; replace it with a direct '/' assignment. The
> buffer is already NUL-terminated, so there is no need to copy an
> additional NUL terminator as strcpy() did.
> 
> Update the comment and add the local variable 'is_root' for clarity.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

hey Thorsten,

sorry I have just been swamped, and traveling, ...
I will start on the patch backlog tonight

> ---
>   security/apparmor/path.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/security/apparmor/path.c b/security/apparmor/path.c
> index d6c74c357ffd..65a0ca5cc1bd 100644
> --- a/security/apparmor/path.c
> +++ b/security/apparmor/path.c
> @@ -164,12 +164,15 @@ static int d_namespace_path(const struct path *path, char *buf, char **name,
>   	}
>   
>   out:
> -	/*
> -	 * Append "/" to the pathname.  The root directory is a special
> -	 * case; it already ends in slash.
> +	/* Append "/" to directory paths, except for root "/" which
> +	 * already ends in a slash.
>   	 */
> -	if (!error && isdir && ((*name)[1] != '\0' || (*name)[0] != '/'))
> -		strcpy(&buf[aa_g_path_max - 2], "/");
> +	if (!error && isdir) {
> +		bool is_root = (*name)[0] == '/' && (*name)[1] == '\0';
> +
> +		if (!is_root)
> +			buf[aa_g_path_max - 2] = '/';
> +	}
>   
>   	return error;
>   }


