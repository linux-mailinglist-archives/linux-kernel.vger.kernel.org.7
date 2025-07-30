Return-Path: <linux-kernel+bounces-751177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB682B16615
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD7B16AF33
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B932D9ECD;
	Wed, 30 Jul 2025 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZelQSJGz"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE0F1EE019
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753899125; cv=none; b=l7zdUzZ6Dt8VU/7rU16tBf0bJczrsk8yjTvH9TSS3CSJrbezs9gNEt/hHX4a1XWiIADnVv24SoJkru98VHyrI0buATBUpBp+ubipxn1U8hdnW4a4fnwIrbnT4Mk65AxPNGy55Pi7fEqqzGR848l8vkaWt0Vpma9/F0aRKU3KPWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753899125; c=relaxed/simple;
	bh=hoh4HkXnDmJqJw/WrI6ycq/Ao/21Hcg9bbQopwz4GGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiW4zYsnzNXzUkQlu4yFw6XQYADCjZD/I7/SyDLPRRl1QNm75tOuPUi2jweQrGLG584mt0+BBBWKJdfV+MFt9cPFJlC4wEGKRvlfDkh0s2+/BYXslKP3uHP6Aml2vCm3xd/593JKfgRSgrzyNCG3IqIaZ+x5ua/fmfR7Iw+IHYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZelQSJGz; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6152faff57eso65209a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753899121; x=1754503921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PoKxUWsGJ0drWlCsSRpNM9dExZbd5oNyuJwK6uC033Y=;
        b=ZelQSJGzbR6mnaeIn2LdddI69XhtVxHXVvDS8o5o5eKdinMMZa5tXCKg8ocs0po8qe
         7vbxQeaRTwdan5ONEmQ43mBElLNXL4CbD8YQPE9KbBsiUOHkcT+gzWWRl7BVbXPhtNmO
         NeE7lW6vn8gT1zJZg7diygH8HzMdqBRedKShM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753899121; x=1754503921;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoKxUWsGJ0drWlCsSRpNM9dExZbd5oNyuJwK6uC033Y=;
        b=ZBjQqzdvPh1ttrfqa8BBVKvWrkZVGLyjd29vtjpVzDmwKn7aDxX8mqoEH/ALjqpvBj
         9cnJJBzXCPMTjXhhFv99EN1Vw8zMokkGFVg9aocJbdrJZ6lqY+sItVmGXDtO9CnMugvk
         TwbeYMRg4Ppemza4Aj4drNZibsUFR21svBEgxoxokTEOyeA+A09ccJqZYaSgEVR1kJbg
         CceEMoZg3g6dO5jAfN1UADjMo696lTdVrghy2TU/x8f+E4X3sMZQbejXCOkonFZTQq1C
         y2NZ/5OYY70k7THB7/NJGU8fFYQIcjvQ4/UHDMcBhXOT9LP1bGL/JfcRueJWHL/GKY2P
         3UVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5U5GFC1pJn1l0a6Y2evQrpHGIKVHdVfQfDdKjfaLviJAeQknFnJ8iD84vep6+PLUEn6YSTbic6bPUMf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmHB3FYS7E8IIL0nuwOaqVzPHw4So+wA9raesJl8IDLieeg44p
	rPiBjX2I1gUISoyaKDkRhrbUTbGE5nw26uabuIq9G99QIciSfTKNpPM7dQwoZp7P38iEPGC0FiH
	cFie0ydQ=
X-Gm-Gg: ASbGncuLWG5yyUOv+gkT2f6yw2t2ESXKBTME3bF8Y1zeEAzvFmErMfRk3S9nbwTyydj
	/7On12N6PTNb/iki0/ZZncxCAcoBwuTVKb79750+AThQGLV4vz+60iwXqotXaFHnpCEh4pC3ymz
	ouC2HCKb+OA+Jo7Al1fYfkb4KKI1VLZs10ebUUM5YNJ7eAjj3f0WPDr1SSlCkBAduE+PP4kFlpo
	IirPGLDS9gFAF1eAo8edlHCMLBt8LPYq2UjLmOUhNAkH7S3/L2LfiwnJCjjvYDqbcH9uGr+kGDR
	TSLmJ9ZqbbihYQpYxR1Cy8YqtXIXb5FVL3DDycocaZR2C7IWqDeVXmJJCc9RmVWHGqNqUoG9K8J
	ldvnCoekoi0e64cPcskfmSg5JBr6M45oNKDmG7elpYc4Ngq+x3u6USjg7Dmx1c8igKobFT+OC
X-Google-Smtp-Source: AGHT+IH2lFJcFhSDKUTW1nOOm0oZ/dOsBkF5aEcD2hM3kUCOtPBmlmW+7BBgOlUC0vRxQIkbaMNTjA==
X-Received: by 2002:a05:6402:180d:b0:606:a26c:6f46 with SMTP id 4fb4d7f45d1cf-615870b14ebmr4096182a12.19.1753899121178;
        Wed, 30 Jul 2025 11:12:01 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a5e2988bsm95028a12.23.2025.07.30.11.11.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 11:12:00 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so52935a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:11:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7IjNsS3m+4AJ1gR4jQIq+AnLNwPORqTg/w5xhIEuD023SdIryMiJHkjtFQQ0Y66XJYvS41Lzmjymjq9E=@vger.kernel.org
X-Received: by 2002:a05:6402:350a:b0:615:9c88:59e8 with SMTP id
 4fb4d7f45d1cf-6159c885b1dmr2065764a12.4.1753899119478; Wed, 30 Jul 2025
 11:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726024605.GA17131@neeraj.linux>
In-Reply-To: <20250726024605.GA17131@neeraj.linux>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 11:11:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1Cjqv08fdm3T3ZSBGN2vhMm00Ud+JjbWthK0RygMF0Q@mail.gmail.com>
X-Gm-Features: Ac12FXzcgjM63YExZi8MiZ1Su9hIEpeaVi0WR1ZQE39K8u8IrcOTSogonMnM4a0
Message-ID: <CAHk-=wh1Cjqv08fdm3T3ZSBGN2vhMm00Ud+JjbWthK0RygMF0Q@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.17
To: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
Cc: paulmck@kernel.org, joelagnelf@nvidia.com, frederic@kernel.org, 
	boqun.feng@gmail.com, urezki@gmail.com, qiang.zhang1211@gmail.com, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, rcu@vger.kernel.org, 
	Tze-nan.Wu@mediatek.com, a.sadovnikov@ispras.ru
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Jul 2025 at 19:46, Neeraj Upadhyay
<Neeraj.Upadhyay@kernel.org> wrote:
>
> This pull request contains the following branches:
>
> rcu-exp.23.07.2025 [..]

I've pulled this, but I do have a request (or two, really)..

The octopus merges look cool, but they have the problem that if there
are subtle bugs introduced by interactions between branches, they are
a pain to bisect. So in general, I advise people to avoid them.

But the *real* thing I note is that merges are more subtle than normal
commits in the first place, and octopus merges are subtler still - and
your have no explanation at all outside of the 'merge X Y and Z into
ABC'.

Please write more of a commit message explaining what those branches
*are* that you are merging.

Which is the second part of the request: when you ask me to merge "the
following branches", the branch names are basically line noise. I'm
not in the least interested in seeing what the date of a branch is.
That adds no value.

So can you please instead describe the branches by what they do than
by some internal branch name you used. I made up my own "names" for
the sub-branches in the merge message, but it would be much nicer if
you did it in the pull request.

So, for example, I changed "rcu-exp.23.07.2025" to be "Expedited grace
period", which seems to be what that branch name was cryptically
trying to say.

            Linus

