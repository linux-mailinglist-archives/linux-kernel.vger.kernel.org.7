Return-Path: <linux-kernel+bounces-769173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A468B26B16
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ABC11CC0EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84488223DEC;
	Thu, 14 Aug 2025 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EP0Zh5mv"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCFF22422B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185465; cv=none; b=syb6upuEodBRsJuiYUEjMkDqHGN6uM2iBmjNIrnaWHkH3QJvFD6Wq1Nfsvzc4JdJBIN5O5GTD+qbRAu5OOvsGInwj8yGAZBka327Tf8oPHCTUV2ILTkm7LCkjBeJeTMyMSqqEpC/piws3SdhpdXvfY1p/JfWDJDB1mHc41q58Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185465; c=relaxed/simple;
	bh=6pEXfEutJZNFRvI9iOQTeyeyiNCFfdCXQmwpC/lAWTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8QExL0b4IIVyVIy7F7YRZI0fzLvMoRLKt7rkPMXSiz7SBu2fjY0rXxZNLVF65ro2JNjJ9qQcsraaV9MNy+CSDkVC+LZ8F8Sut4ehJOfpOaHY7hmH4fbku7ogYfiY9Sou0ACrUTryWM8VIb0M2YqVOD7EJ2Arus+LIGf6NuLKNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EP0Zh5mv; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-88432ccd787so59217039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755185463; x=1755790263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P81sLlQTBntaiAmYzutesJIvj0Q6YtF/nY9RwqB2OPg=;
        b=EP0Zh5mvgRkeSespWlx8Bxo1bZi+JsDUlMxfzcjBx7PvtHBc0cZtFRz6kpVWSRATGZ
         zhxIA9Ef/z6NwcRL9JWdei1bNjySEyR/oDVYv24Xp1BPHJd9p0YTxmR5qZF7SVrGBmFn
         qPf4waKU4d8FWl+vY+VWHT876/DLdAQ27xonc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755185463; x=1755790263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P81sLlQTBntaiAmYzutesJIvj0Q6YtF/nY9RwqB2OPg=;
        b=fG36dTiz2RTkIb8tmVk/A8pGYD1vUbPu2wgGBqY/UZtFKHVCNgTwuS26/iLRBK1RUw
         kpBOPOcfMuDB2SaSyqGAvSKFzh1HlBnKUDkYfYKGafALc6AHLTEnMw9R053J65qr2LYE
         awBIxjovmjwpeTItAiy6oRgzU8XNjIPMf9OtCayhPE67hNU1nWkx/yZastdDtutpQ3JK
         qolQXtOBtLLW+Kh87Mi81gzmmm123QPig3kemDwx0W2Xj1INlsctM7Kl83SnjJApe3GM
         DBm0A0j2jOfYPjhZybFUNQYlxS1Gz5tollIF11HRbYEBkyipAw5a/56BYxCO2s9+J+sG
         ZQaA==
X-Forwarded-Encrypted: i=1; AJvYcCWQFww8YhMuxnR8Zcft+wNP5YUGxI0Gxzl3KzoQ3QEqYJrq9D6u99ojJolgLZAzsnYP2yyh+qIzG/gR5zE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8a4tRUf9tsZj4JkqWtoaD6wi9aNANge7IOvqUEOGUzhqbRhUY
	DjwPAo10uNqa22P7cM3oFSJKZ/+l8ZhwXOjFj7ptw+3jHw6ZFa3yuuckPqCOb0xiIx0=
X-Gm-Gg: ASbGnctVF1J+FPvUIsghkIXhtksVbz+ZqEMRi3Eom3r7HWR9QN19vpHKzgmEPh/FxZ0
	axXMtW6ot+YxufCYjuvDe1gr0Ig7uNSH06TN1OJNYrYLMHsZDVx0N2lHOX5m9I0ZqfRTwlAfHrh
	s7WP+v4wz32M7eMvW/hgHA/EbthllZiZJxDCDQpvz6rtwFWK2qVmA4DhC420etVbvDPki6GGG5U
	4EiYr64kX5Wr7L5djIIjRQBLxyzvh6h+por4rHjfjQhk7gy7ku0DFInMyS6/rPYvOgUi40QvHKi
	zRuf4UuyjBanEUomxwZMyHkB1n+JS0mcBIQ368n0fwP/QNj0aQW8UX5LBS4aN42E4xriXYA9H0j
	5JBw94tqbNxOMeHUCSJkEElBKoV97A0mo+0v5g3UBy6dpEA==
X-Google-Smtp-Source: AGHT+IHqEzRf3rffyzPsHD2EKsF4U453EP+95KNO41JbKJnPnjn6DHb2sPXPvKuMmoj+GWLiCfXedQ==
X-Received: by 2002:a05:6602:148a:b0:87c:38f7:556a with SMTP id ca18e2360f4ac-88433c9b735mr588192239f.8.1755185438769;
        Thu, 14 Aug 2025 08:30:38 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-883f18d5d77sm535160439f.14.2025.08.14.08.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 08:30:38 -0700 (PDT)
Message-ID: <08a4b41b-fdcc-4104-b02c-ec28078ae80a@linuxfoundation.org>
Date: Thu, 14 Aug 2025 09:30:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] print: fix spelling error in message
To: Madhur Kumar <madhurkumar004@gmail.com>, aconole@redhat.com,
 echaudro@redhat.com, i.maximets@ovn.org, shuah@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250814144916.338054-1-madhurkumar004@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250814144916.338054-1-madhurkumar004@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 08:49, Madhur Kumar wrote:

Missing changelog - commit summary log is missing the subsystem
details - selftests/net: ------

> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---
>   tools/testing/selftests/net/openvswitch/ovs-dpctl.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 8a0396bfa..b521e0dea 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -1877,7 +1877,7 @@ class OvsPacket(GenericNetlinkSocket):
>                       elif msg["cmd"] == OvsPacket.OVS_PACKET_CMD_EXECUTE:
>                           up.execute(msg)
>                       else:
> -                        print("Unkonwn cmd: %d" % msg["cmd"])
> +                        print("Unknown cmd: %d" % msg["cmd"])
>               except NetlinkError as ne:
>                   raise ne
>   

Look at the submitting patches documentation to learn how to write
commit summary, logs, and how to submit patches in general.

thanks,
-- Shuah

