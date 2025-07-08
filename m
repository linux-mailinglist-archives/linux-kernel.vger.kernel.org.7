Return-Path: <linux-kernel+bounces-722312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAD0AFD7C3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48013A9770
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E19E23D289;
	Tue,  8 Jul 2025 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="NXRpQhMA"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630FD23AB95
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004792; cv=none; b=TtgTlvuxlgESlJnPj87YBNNW7yZIJqczk32yS3tv4YKmhXjoMCzn8n+BhLX+x0kasvs8zaI2w1JP14I5bunDpt7rnudwFojxNWQ7I9VmIUI7O4ysMRCLkVyRCx+KABHJE1/lz2JFsbHClGtF1XI7B8RV0RMexU54+y6+RtTMg4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004792; c=relaxed/simple;
	bh=sKuB8RQnIfm8FxftIf3X0GOfjjaSkos0VBJiEDTBxlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+xmNf7qzvTRdixttU4TrVGZSq4FkOYz/8wiwWG9tTRRAVeVhutM/REWlWmX2m1vcJcn3ipEGkMrBn9kiBaUKbbBWETRtehduGLf1V6hSi7KH/Z8P4UwJAHSKiDrUXl2eMdjvUJXEOpHCw+fpU2Yy4o0A6FPqUfmYRELM2k0eFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=NXRpQhMA; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-613b02e801aso1374634eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 12:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1752004789; x=1752609589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SB9GNWWsPYQTrcDwgkvbanghflj6Omk2OsXB5XCpSp8=;
        b=NXRpQhMA/FpyyK9ugKn2f54J29Fkp7plVmPA087Usg+7HunVn6qRtpXsRb8bjvpIJK
         xCN1s282GYJQz6nJBm8SsMwcAfPHmr2eOHatMnmK4rsTiBJ0jp7OZZGVPmlCUa5Alll/
         PduaT6o9ewKQ9eGzW8QiI67A5UMIERt8zLO+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752004789; x=1752609589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SB9GNWWsPYQTrcDwgkvbanghflj6Omk2OsXB5XCpSp8=;
        b=S7PVw9wsx8Zl44uAByxVf9ECPMv0y4lnN5QFKLjetX7IpGEI5tuEQ6mS3g5kJQxMeW
         Jgjqkc7b9BRnEClsOkYNYpDrt/g81Z2oFbAjWLKmw0HRO44DsnokbOgYunO2oQYpir/A
         wPGX6CkdHTSKr8k6BBdfhXKTpIAavb0J8RnC4GLU1eqDXcPqQw9yb9HpNYibzehXUc3S
         Vfpatf2tDHo4amvELEHPTZxW6uXB56QkMsnh2Sae6qOOA+I7Xc0xlV+OkepJzf5J5HT/
         dHANlnO+PCBssrvPow4UVUP5ryu4jF0/Jz1/1pA2/rnJtqFA2OX1He75aQa5sRE/V06E
         V3lg==
X-Forwarded-Encrypted: i=1; AJvYcCXwPAbzeJ3PBZMan94emDYlFAR5zglx9yrEa6tOzcK+XubunAEuc0/bwq24nTStGDGsik0oD+O2Z43/dnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJUY1jwfT+FzOdzTbOI7BrbPytB/vui/3JMuoc6YNWmGsIh02A
	+79UrtcMs7yWTOcH0mVOEawUoufNkyURe8mN97ZYyP881+rX2smvXoX1pnQ/+blA4A==
X-Gm-Gg: ASbGnctDkwsDiZjsOi5C1CpMsru7l4rA0spMXV3+1pnLvT72qLBnXQvqK5tj8+CNGQM
	hMJGQ8WNwHayp/59Fl5nu7j2dtTYFbElbwhOiVu9VBMuw8sAQdnfljVgY/qF6E2MSgk2dfpfxGA
	zLx92gZzwBhBM8PSRY/fQCJBnlu7PtJQ7ruZXlZLHEbaSSRA12qQ9ObxHrkwGyTZpsYTxGox2d5
	gsNY4Ct46KPphEuwTPF9y0niAhBYzoKVj5hgJslLYNE3KK6MyItSc6b5IWlHtJ7XH8uBf18t2H8
	BBIAIYS88PgvjHmVXSb8Wu28EBvWsXqYcRuLcCJSr8bvf+XfrCGLGIIDNI7hGDAvhMG6OWT1kCg
	ZqXcppQk4drv80w==
X-Google-Smtp-Source: AGHT+IEtr03NSkK6ECFSDZy0Tth+9Bq9hzDGfXM4PYpkiHw9hwDD0Kxv/StPhidCcUjve7ewHnoJDw==
X-Received: by 2002:a05:6820:210e:b0:611:e30a:fa1c with SMTP id 006d021491bc7-613ca6b5916mr758011eaf.1.1752004789129;
        Tue, 08 Jul 2025 12:59:49 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6138e590c86sm1790207eaf.20.2025.07.08.12.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 12:59:48 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 8 Jul 2025 13:59:43 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.15 000/178] 6.15.6-rc1 review
Message-ID: <aG14r1ZicqU4GNbI@fedora64.linuxtx.org>
References: <20250708162236.549307806@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>

On Tue, Jul 08, 2025 at 06:20:37PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.6 release.
> There are 178 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Jul 2025 16:22:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

