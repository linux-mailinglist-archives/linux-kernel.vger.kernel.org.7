Return-Path: <linux-kernel+bounces-734405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58982B0812A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FC2A7B2F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 23:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AF32EF65F;
	Wed, 16 Jul 2025 23:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuYO4k+3"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F7621CA1D;
	Wed, 16 Jul 2025 23:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752709949; cv=none; b=ruDbjAOTMFwVGCRKf5Ib77ETpSM+9/tlczh8pYpXx5uIbXZkzrK+uHILi1YwTaXt1X7LknUKVkkSgd6zbDU6+na0o1sUxNYdnfzSCz5toGOCsofimF0EOaO4hA+Y6PArdBD3R8CStpLscJj3gBo7lveqj+Xym5LKJoNjmq+4yyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752709949; c=relaxed/simple;
	bh=tLcXQCfFKpH9tAyjQMjTNbYv3p000cu/Lr+Fw926E5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkY7ir/Z5bSVW9XDyuSgF21qOKGNcJcMXcy2FB/KsBvIF501aSp+Pp04ROuMVCC6CckktcyaO/ormxoB91RKtZiBLUHBoPJ9eL6QenZPU1/Xf2mcGMCJ4vZMc8Ga7yxYRuXfEAbYwhKLSyf5rVYcNSRHgTC8yXtF/mPSlISZL4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuYO4k+3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-748feca4a61so277927b3a.3;
        Wed, 16 Jul 2025 16:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752709946; x=1753314746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jdLXlQ398AT3n/w6cQxZKaJPYRsk9stO2iyTGlX4yIQ=;
        b=GuYO4k+3rJdUUhxdg+cJLy2vho85eWIkLMc1CGzmbqJ03zCm07lgM7WyfLIe++qvE3
         MPZ4RUYDA/u7FYmAWrDjZMH71+N+Pqkb4m5QeKZiWSfTHgAsNIDb/O/twQa2Ufy7Msa4
         2jehc01uVgR/PmuW26766jXe2Kb84ymNjYi2PKvaB/jbEqnCiCAIkYtjIiFfYEknzxsm
         oAMALFB+9YYNY89ocvonlilf78g9SVu0yoRvkbyZNrp1xt6cyyPbROkNt7wXNRY0vCQR
         hj/tBNJgGRsAGfwjW9FtPSj2UnHUIQ8luGkNT5YdFccnJiHnW2MfJJA25MKIttGH3c6x
         vYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752709946; x=1753314746;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdLXlQ398AT3n/w6cQxZKaJPYRsk9stO2iyTGlX4yIQ=;
        b=g+SI249G6QU6l2gFfKCmJOImLFk8ZdmizG09o7yKirITfCKuln2bBY9PIZDFBn4auf
         COYb9e0oy5/kuUjIkG4rdwHpkRJ6W8YXt31Dg3RFkrn7Eih3ELDNksEH/08jeNv0pNbd
         bVzy5ni2y3O+KS1Eqe3k+VwIyTP1QFMLq4Dv1J35Ov3X4HiIFklqlQWotaKenYk8+p5n
         P28xktCWtOXxW5VDY6YO89GCIllC7zx77xX9DedRLR4jg4Lu6Edkzw4OOnRXSCZ3/+nE
         sdcg9SgYFucMfAHQg9rSn/qrA/PzEgNfanKDQlVMN5U/KjZLpIqA/5l4v25GoaOfYbRq
         vOYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHw1+J82tVwQarOy3D2nGLSwkUp87wEva71FjuQCA3R8gGL05mYjFz6JJgb/HC11gXd87aI4VoklOSr+Rn@vger.kernel.org, AJvYcCVyUF/lht4PPcaDhFXH7aV3PkmD7xUbSUDMmUUE/YB5e1uVdjMtpkw+9Qs60nEZ/sy9xDmlNQKZLOxP@vger.kernel.org, AJvYcCWgmpEN14VYhv3VTk4OPnO7RyYDPnSQMskDsG2KBEsImBNbiE+X6Td8Lion8gk7ng5psUMTozhlQn3nfaA=@vger.kernel.org, AJvYcCXJQX2VRnENv/PvqAQI5hACIer7dVGslv4xx/+c1UMTRP2YiCU8IYySJTO8RZ9tQ7rwVCdkiiOrA8AB@vger.kernel.org
X-Gm-Message-State: AOJu0YyW1ZgID6TYZGplWwojMkwlwFa11gKEcT0Hq6phb2TJ84cvf5WL
	FsfGs+eKfIXsr4x7x3q/Njmvrrb+M16NpfKuhzudRRvxpNTetUOpTnm/
X-Gm-Gg: ASbGnctQDRT3oBJbCy3GPBD6Ng4FZwq6Ow3h8JI7+wrkWhKP6758jro/CXaKogrsPc3
	R1QJyJ7qKM/RnwdwSbYfHE4st02/0etVQM4aZWqyFGMZts+QE6mpT+H2VDsl6lNsyxOel9PiH21
	C+LpcK6sJEStuXHBKdv9gdTWQsa5vxyRL5MJQL4C5lKyTiIqwBtEAUwLlN3e85/3oPOaUrvg7Qk
	h6n6WwkyNm0CFSc3M+6sRqJKTuK4KGuKpyx3aZsCf+7YPpn5y5IWL0mj4/QJd1vr4tbTCqB+nsV
	aQ86UnJK9TSVZLz6vOAffBq1ELdRR/Kqu9nXGbvwGAgG9ls1k/0atUlUlA+GHft+G5jrIJB1Y0r
	sSsz1I0WpASfKGwW3ro6t5vRJ8nw2Bdwr6IjPUprCjxH1tDmBwCvMKb1GPA0JLwPU8ww8zss=
X-Google-Smtp-Source: AGHT+IFt7XBfausG0DgvJ18YaZnajB70cE/ued1Px0iX7hfmK/LW8zAdN9Ef9VpVnLqF8pNdZvf8Aw==
X-Received: by 2002:a05:6a00:1252:b0:740:a023:5d60 with SMTP id d2e1a72fcca58-7572427b8fdmr6194614b3a.19.1752709946303;
        Wed, 16 Jul 2025 16:52:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1d507sm14920239b3a.83.2025.07.16.16.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 16:52:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6a72e973-a142-4592-9b11-908a49f8df13@roeck-us.net>
Date: Wed, 16 Jul 2025 16:52:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hwmon: (pmbus) Add support for MPS multi-phase
 mp2869a/mp29612a controllers
To: tzuhao.wtmh@gmail.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Naresh Solanki <naresh.solanki@9elements.com>,
 Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Henry Wu <Henry_Wu@quantatw.com>, Grant Peltier <grantpeltier93@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Cedric Encarnacion <cedricjustine.encarnacion@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Cherrence Sarip <cherrence.sarip@analog.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Leo Yang <leo.yang.sy0@gmail.com>,
 John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>,
 Kim Seer Paller <kimseer.paller@analog.com>,
 Alex Vdovydchenko <xzeol@yahoo.com>, Ninad Palsule <ninad@linux.ibm.com>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: peteryin.openbmc@gmail.com, Wensheng Wang <wenswang@yeah.net>
References: <20250630112120.588246-1-Henry_Wu@quantatw.com>
 <20250630112120.588246-2-Henry_Wu@quantatw.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250630112120.588246-2-Henry_Wu@quantatw.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/30/25 04:20, tzuhao.wtmh@gmail.com wrote:
> From: Henry Wu <Henry_Wu@quantatw.com>
> 
> Add support for the mp2869a and mp29612a controllers from Monolithic Power
> Systems, Inc. (MPS). These are dual-loop, digital, multi-phase modulation
> controllers.
> 

This patch needs to be consolidated with the MP2869 part of
https://patchwork.kernel.org/project/linux-hwmon/patch/20250709093420.456304-2-wenswang@yeah.net/
That patch uses the _identify function from the PMBus core instead of re-implementing
it, which is a plus. It also takes more chip configuration details into account.
But then it only supports mp2869 and not mp2869a or mp29612a.

The chips do not officially exist, so I have a difficult time to determine
what is actually needed or even makes sense. You'll have to determine that
with the submitter of the other driver.

Frankly, I am not even sure if I should accept drivers for chips which are
so super-secret that the manufacturer does not even admit their existence.

Guenter


