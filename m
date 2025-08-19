Return-Path: <linux-kernel+bounces-776520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BD8B2CE69
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C463525146
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E907342CB5;
	Tue, 19 Aug 2025 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Yifq3M/z"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875E128137A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755637894; cv=none; b=PcrTLpMXraI4qn8nlpshm7MZRCTqgCsSdodQdQCmtB2g8Nto/DJI1hKghClhnd7CrPL8gok/dzyeMlklS3k7OwPqnOhMM/zje9w8PbR9utrING7JMMazST6XBhsWrTvUOS8CpuoITy1qXEMPxXyaerz24SgPkCVg/3jFf4xqy2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755637894; c=relaxed/simple;
	bh=I/3mWa+i3KERSamxNOpw1Jf3cJLvxbsmqYH+/Lbkfpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hALez5v0GYdWT1Qs12f3Aq6eW4rrmbL+b+h9HXc8629vovS6KyNeYy5+iODsvdagGXz8m3bcqZUPB4d0IXuuzGJBDpy9oy5ov7FcqJnlmWENHzGIti/rSrdq7G+DNwGM7o6kLQcQIcs5JFQsejYHU3ap7EAalu32OxpAIr6zScw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Yifq3M/z; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3e66b5492c9so14850685ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1755637893; x=1756242693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8q+y1CzQiuYlKsWREpLAsdkMHshX9bTedI6C92fr3gY=;
        b=Yifq3M/zSRlfatR3JssW67OH7k/K2Ae48tIlVkEgC0gGLG/hNlFPrLa148RQ0Yg+Sn
         CWfngvqcNwaQOztV83d7Sy9TZXhhnVQiZEQH7Qq62LdCnwqbxGy12U71uMWP3beMLRfd
         mwERt2kB58wRlZg/Z9ggZBLSrOoxgnc6lPZNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755637893; x=1756242693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8q+y1CzQiuYlKsWREpLAsdkMHshX9bTedI6C92fr3gY=;
        b=R8YSwM6OQJUPhgcgTF0LTk544z7FMCg30lJ/YykfPrpP8gbsIcWN+oqe2Yp1zdHOjU
         bgnyQc94VcJRTJJgnCuA2ZNS09duE2P6pGfBMZt4xElZawtHnDzTRBjkv6xST/Cxs5uo
         jj6m/Hm5mzRCI4BF6OgcHt8FIO7zkkFT8ruo4xI4nBt9xNy5M5mgp3I8jP9meIEdJiG9
         kz/wFNp6wca+9kfkDZAXltIUZ275hKUldVOJ6EV/E6h/FLmGO/fCu4aBbgBdMF6GsE13
         aBBrbieLz0vqCx0zdLQuEl6uOtCkL+1IbK6OVNbmourw/qSB05aX/awXkzIRwOR62dkv
         zpmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl7XETZR5Ld4Q98qRE9TxSVrgExUEzEVEZjKJhnRHSzAA7XhaEwPb+DOI1HZvU5IpCWZCKNgp7leAkMHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi5fcPVPx0Jei4bmArE6gEqkxvgLAAK/4HPjHPhHLOD7vSZNq4
	XDsdcDNgRL4LlpGvWylIAFoiiyuZglh0nw/fVDmCk4tjInBwJoDFjzn5sZK5Dpt2/A==
X-Gm-Gg: ASbGncs2MF8H5ig2l8t7YqsP26cpxO5KzhfsTD/ef+/oohWN300tlE4pmA5aqNyty/j
	Qi/C5rOiS1oH55gji9BQN97zb0bvGSCM4FqeTIv8HqXzhQZPdzLYX5s6ckxzKKWh0z119JYXKaK
	Jmjq4l3BkBMKGXnNp8rXXEkzbuDUrWxxLMpqmT+Su5PHmDV8mDhErvJuPDSyA1ZfmeVBfvu4dFc
	u+5d6tAve27tpYXuZ8RjSQisXeHqWJj/DcCeLBCMLD2zQ7oMPC0TMWdp9rhfpzAusu0r4elhXkV
	9EMzAeaZWriVxVcrsINB+n9V/RZmM6dc9taxmczQLfl8btcKiWAmUu5R6TH634WS+1hxed/jtvo
	H/XHYdTS6W50tWI/wn4gqV9/r6WOTkoqsVxEmSrlGI6WV7L/ysO4=
X-Google-Smtp-Source: AGHT+IGTxbTK35PyIo/Fygy0tLFwzQOJr9aOpFhZb3m3EzsvuRZ9OgR3OsPMRlr1RPLn5Tpib1E+6A==
X-Received: by 2002:a05:6e02:380b:b0:3e5:62a1:c9dc with SMTP id e9e14a558f8ab-3e67ca67d91mr10240565ab.12.1755637892657;
        Tue, 19 Aug 2025 14:11:32 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c94a2cca0sm3719083173.86.2025.08.19.14.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 14:11:32 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 19 Aug 2025 15:11:30 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org
Subject: Re: [PATCH 6.16 000/564] 6.16.2-rc2 review
Message-ID: <aKTogt5fSaCpbeZb@fedora64.linuxtx.org>
References: <20250819122844.483737955@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819122844.483737955@linuxfoundation.org>

On Tue, Aug 19, 2025 at 02:31:49PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.2 release.
> There are 564 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 21 Aug 2025 12:27:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.2-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

