Return-Path: <linux-kernel+bounces-760652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A382B1EE3A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3B9567BDF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2D3217F3D;
	Fri,  8 Aug 2025 18:07:37 +0000 (UTC)
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23051E5B91
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 18:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754676457; cv=none; b=p+g8U7zPIQEmG1TRol685XeLgNVv7rzu7N9ugGC9CX/Km8w/TwYcEVJyb5sUiKS9YwHvlEdYOv+tz9vHGKB+6LtvFudvAXCJu8WlCiBujUA8m+s1HlkoLjveJkXkRcDzgBWRWppQscpJZL/pFiHeYMls4kdGmw7kLR44zlltGqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754676457; c=relaxed/simple;
	bh=y4aTgjecTMm7mWG9roqV7jvtYXxn0wcHUtjjq5zztQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UOhYZPCuba8ujQwvMTlCzff+Xds0cb8PsTbDgAo5/b+79P4t/QF8VNLXOId7397izr9ePPQTCjnK32B4CxiJfCIAbp3NaaJaMGo4JY/ifISteKWSYwIk7hqrOpY14IxXNN7TQYnGnc38I9NNYklLZi3rdsfY1uEGOw9Tq1fPV78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso2542345a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 11:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754676454; x=1755281254;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdZE+LrZ1Dtr2wN/ldnaGqQLq+Kia3E7wlZDmnHjMTY=;
        b=EB6b1pSjLacfVygaFF0F09G0g+ZMbzPFZEikUnn5FtBX+l8QwF/wLIGwxoZb9ItGNn
         vOVpefHxDye78o389bb9n/D9PnxkdIlqLDZQQNbmBXnJdEQh5ou9fpDeTEpumE67aUEd
         YwY83I2FVM4jAZfP0+k1B0ckedt3eRck5xrO7GhRBq2nHnKhfmckJoESjCaOlozzty/Q
         Jrh/ckLncGS1PQTsmeg62HMnevAssUBIG2+gFeNzcoOd3vdx0KqJD+DtI5HqSZJf+hQA
         2UfOkzZeoNRbawJNFo/SsQSxkAPCdbzxX6zE6uM6k9Ic8P4JLPqgY9nVC/S4NullowAA
         /s7A==
X-Forwarded-Encrypted: i=1; AJvYcCXVSPQuvKsZULrJBm6eb1M670mS0BrfynXCgsNFIgjUV9tLBQG65Pmq0Tr6eru4/8YfO8Ad/YYlKkm1Se4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0XxKm9pegH6spUIUvhGdgfHV6aCKpxVWkg6R2HBuwqETPz6dc
	o2sY6JnTckEMdN0rzs0QPTHBLhtDU2Hs7PPk+FC3bHL6fd6gb2/QojYfqQxB9JaaQOprmVp5knO
	y8fKNXXoWeA==
X-Gm-Gg: ASbGncvHbLpFAwRXFKHfBjoNS31A1BMtzCyK4mmItlF8KnK1Ikk2IoY3/+X0xgsEZWy
	YOHdR9TqInbayg1VR3nNL95J7m6zs7l/DFJettytY29Pr9x1yewlh5xDD1oTzk9GZZqg0UjFfnH
	pMnyMBGaA22xgANl1c9GLz+a9dOY9rmgWVX8W3hKgGJlbc6rKt+Hrljer2vfEKfDrBuaJlWjGuD
	v8grc5161/rm6VC8UETNsJnu/QEOlf7zVRNrzT1DYkN/KKkxf9Kk9/s9UMqesQYVue/JKUaxrMa
	zbAEiBcBtXANoBSMKPhMo3nCsIjjno+PG5dKD9maFxOXrgnTamhfS8/dk7JS1zVI/s3/IL1Fr5e
	L4Qa9h+nlbOluLHcN2ewz
X-Google-Smtp-Source: AGHT+IH35AlHh+s+M4//5c5YAnKFpceo2gtMQAaeMl/FUzycglSJE0ISmMUC/H0y13AQEA96RBISWw==
X-Received: by 2002:a17:902:d4c1:b0:234:e655:a632 with SMTP id d9443c01a7336-242c225f5edmr58470705ad.51.1754676453957;
        Fri, 08 Aug 2025 11:07:33 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef658esm216589265ad.3.2025.08.08.11.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 11:07:33 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, corbet@lwn.net,
 linux-doc@vger.kernel.org, workflows@vger.kernel.org,
 josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 1/4] agents: add unified agent coding assistant
 configuration
In-Reply-To: <CAL_JsqJW206w1OiOZ+4nMg7XyHQq7QnOyTWM0W+DyMmu-gpAjw@mail.gmail.com>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-2-sashal@kernel.org> <7h1ppxcp0d.fsf@baylibre.com>
 <CAL_JsqJW206w1OiOZ+4nMg7XyHQq7QnOyTWM0W+DyMmu-gpAjw@mail.gmail.com>
Date: Fri, 08 Aug 2025 11:07:32 -0700
Message-ID: <7hwm7d661n.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rob Herring <robh@kernel.org> writes:

> On Wed, Jul 30, 2025 at 5:06=E2=80=AFPM Kevin Hilman <khilman@kernel.org>=
 wrote:
>>
>> Sasha Levin <sashal@kernel.org> writes:
>>
>> > Create a single source of truth for agent instructions in
>> > Documentation/AI/main.md with symlinks for all major coding
>> > agents:
>> > - CLAUDE.md (Claude Code)
>> > - .github/copilot-instructions.md (GitHub Copilot)
>> > - .cursorrules (Cursor)
>> > - .codeium/instructions.md (Codeium)
>> > - .continue/context.md (Continue)
>> > - .windsurfrules (Windsurf)
>> > - .aider.conf.yml (Aider)
>>
>> This doesn't work for aider, probably because the .md it links to is not
>> YAML.  When I start aider with this, I get:
>>
>>   aider: error: Couldn't parse config file: while scanning a simple key
>>     in "/work/kernel/linux/.aider.conf.yml", line 3, column 1
>>   could not find expected ':'
>>     in "/work/kernel/linux/.aider.conf.yml", line 4, column 1
>>
>> Not related to this series, but related to aider... I'm curious if
>> anyone has got aider to work with the kernel repo.  It seems to have
>> problems with large repos.  When starting in the kernel, I get:
>>
>>   Unable to list files in git repo: cannot close exported pointers exist
>>   Is your git repo corrupted?
>>   Unable to read git repository, it may be corrupt?
>>   cannot close exported pointers exist
>>
>> but neither claude nor gemini-cli have any problems with the same repo.
>>
>> The aider FAQ[1] mentions using .aiderignore to ignore parts of the
>> repo, but even with an "ignore everything" rule, I get the same error,
>> so something seems wrong with aider and large repos.
>
> It worked for a bit for me, but then aider fell over after a while and
> refused to run with errors accessing git. Some suggestions to repack
> the repo didn't help. In the end, I just ran it without any git
> awareness.

Do you mean just using the --no-git option to aider?

Kevin

