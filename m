Return-Path: <linux-kernel+bounces-744516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B47B10DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1D91CE36AD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4519F2E2EF9;
	Thu, 24 Jul 2025 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FK/ZV9Uh"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BB3241CB6;
	Thu, 24 Jul 2025 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368094; cv=none; b=nn2GgCSl9anGQVfhHUyJgBuGx7OdbMOhxnsZcHlV18ohWUqHGfGK8QwyCP5WqgH+5wiZiJG6IR2jhGrJJDKl9i6HwtMIZ1dcbMIynYNXGKYFC0q/UBzq+XhHaLoYD02REfCaL6Z0R4UIkZ51hdoAbGJi9VS0UkGHdmuJnya2do0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368094; c=relaxed/simple;
	bh=l3InA3QvUG6UI80H+l7Z9twJXQIZ4d6/eIK0Vxqvx58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aKYRrKc90ip5bfDya3q8ymckqWb2KaKa2Z4BKLAMBXg1kfBHniJfgFrvF1YzM/nA/UNW5yOnP33zjvlZ+KvhxgNMy00c6o3f0eY4JuBghK8DGIuL1LVLlmMcIGNgk7ZauhlrjVCXzKh5Tz6Q5M0UJi86ziqLVNkvBf8/slR6ppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FK/ZV9Uh; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 80BF140AA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1753368092; bh=5JfPBM/8KGP3IXfMBLiYxvirkx56ZGz5STtQrj4NSDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FK/ZV9Uhmv/v1lKa1omvxJ2t/LEfIaaMBnVPCer4A7exVXHUHE+o2gbejsFFtGLU+
	 dVcWIFunoAJ6sfXqCUDyMwOsXWDuP+bWtt47Iza3U4iC2xO20ya8NAKnxn3yd0M873
	 E5YJzU8K11FaMT96F8qxATppYjv6faIpTR2faIZ/crIpgnuum28l/oEg2r5JCvb6Zc
	 Jfu4/RCE1n7ioiOtlcGukpPXaJ4mqGZkDn0Bh3bTRB+Yk3YCnJFde2EMbxqu7sYjql
	 LS/3ZZR2EeeUsrpJDHBiRGbrahaoAHTGjplZt3Mf7zE8MO1i7Pb4+NdJDsDC+KzGVd
	 DSJ9WuGGHdgFQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 80BF140AA9;
	Thu, 24 Jul 2025 14:41:32 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <mudongliangabcd@gmail.com>
Cc: Zhiyu Zhang <zhiyuzhang999@gmail.com>, dzm91@hust.edu.cn,
 si.yanteng@linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] scripts: add origin commit identification based on
 specific patterns
In-Reply-To: <CAD-N9QUBDeX2tU50i292Rm8MGeGZ9icnxkb1pAVDYi+SYCdefQ@mail.gmail.com>
References: <20250713163418.1459-1-zhiyuzhang999@gmail.com>
 <87o6tia8ck.fsf@trenco.lwn.net>
 <CAD-N9QUBDeX2tU50i292Rm8MGeGZ9icnxkb1pAVDYi+SYCdefQ@mail.gmail.com>
Date: Thu, 24 Jul 2025 08:41:31 -0600
Message-ID: <87a54tabxg.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dongliang Mu <mudongliangabcd@gmail.com> writes:

> On Fri, Jul 18, 2025 at 4:09=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> =
wrote:
>>
>> Zhiyu Zhang <zhiyuzhang999@gmail.com> writes:
>>
>> > This patch adds the functionability to smartly identify origin commit
>> > of the translation by matching the following patterns in commit log:
>> > 1) update to commit HASH
>> > 2) Update the translation through commit HASH
>> > If no such pattern is found, script will obey the original workflow.
>> >
>> > Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
>> > ---
>> >  scripts/checktransupdate.py | 38 ++++++++++++++++++++++++++++++++++++-
>> >  1 file changed, 37 insertions(+), 1 deletion(-)
>>
>> So I don't have any objection to this, but wouldn't mind hearing from
>> folks who actually use this script - has anybody else tested it out?
>
> I=E2=80=99ve tested this script, and the new origin commit tracking
> functionality is working effectively=E2=80=94it can reduce the number of
> commits requiring updates.

Great, thanks, I've applied it.

jon

