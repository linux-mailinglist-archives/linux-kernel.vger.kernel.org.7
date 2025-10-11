Return-Path: <linux-kernel+bounces-849011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C545BCF033
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB2B19A1938
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E311B142D;
	Sat, 11 Oct 2025 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFBHzu85"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1DB1400C;
	Sat, 11 Oct 2025 05:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760161630; cv=none; b=DLqKZqGxOJFagqBmtylhnqkk2j+Y77fcj8RxPpQ3uCR6P5AAnIv2zb9BDd4ofrbgjrJ1ruwNYSEKheqzX7HJEg2EwH2EyjMr7iueJp6fP/GTZnsIcu0IhnqN9QtApygdCBCJiaHp2GDj6w7IO3tt8r6apqUMXvaVSkrI7od+0o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760161630; c=relaxed/simple;
	bh=Fn8HoxZcVkSiPeP3xP5i0QPr7v7ju0gWeHOPO3Ykcuw=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=m6DxY5v5f6EzkS4QuvNfv9m3woU09xiRD/y0s3lUgE8IPXqoLehZj/5wV92QfZGz57fENCjyguTXpsQZqyc2DpaJk8ThffW30b1kmE15qjlP2qRfeaOLnOeifWVTZ4gzG0kRCcCllAeGCw5TKB4sxRwAhi7eLGTOy5olLtsnolY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFBHzu85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B19C4CEF4;
	Sat, 11 Oct 2025 05:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760161630;
	bh=Fn8HoxZcVkSiPeP3xP5i0QPr7v7ju0gWeHOPO3Ykcuw=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=kFBHzu85w0ioPhfPpbZeubTwqbHaczDbtfjJLwCnePbw3Hnp8Mtgma2uAUfWImS3e
	 AWeINVPBXmJqGaDxdwBj2ZQg+6gMNOzFd6vBeILER2duWR8+Msmpc+tpBTOs1QY47H
	 5Fq1Jr0efAHY95xHYrdTKhbtS5/031BQDCLVI3nI0LjrBC4HzKBmbgZeDtMl1lR11n
	 tBKZfB8sGRSn89gFGh3P5aSnzICjP7IVwnF9eeYBOpaxwQZ8cghn+7jQTXVAjN/n8N
	 KnhD8HTd/pJ2H3RQL+aicZMSjaG7F2HbQNc3BQN1cgsSsgLq0DdXABbJlm7XeT++h5
	 UCpQdSM9KMEJA==
Date: Fri, 10 Oct 2025 22:47:08 -0700
From: Kees Cook <kees@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>, lirongqing <lirongqing@baidu.com>,
 corbet@lwn.net, akpm@linux-foundation.org, lance.yang@linux.dev,
 mhiramat@kernel.org, paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
 mingo@kernel.org, dave.hansen@linux.intel.com, rostedt@goodmis.org,
 arnd@arndb.de, feng.tang@linux.alibaba.com, pauld@redhat.com,
 joel.granados@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v2] hung_task: Panic after fixed number of hung tasks
User-Agent: K-9 Mail for Android
In-Reply-To: <d8c6762c-e08c-4b7a-92e9-7dad17ad0b49@infradead.org>
References: <20250928053137.3412-1-lirongqing@baidu.com> <d8c6762c-e08c-4b7a-92e9-7dad17ad0b49@infradead.org>
Message-ID: <B0A75949-C40A-49E7-83BD-58D6BD5A1493@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 10, 2025 5:25:05 PM PDT, Randy Dunlap <rdunlap@infradead=2Eorg>=
 wrote:
>Hi,
>
>On 9/27/25 10:31 PM, lirongqing wrote:
>> From: Li RongQing <lirongqing@baidu=2Ecom>
>>=20
>> Currently, when hung_task_panic is enabled, kernel will panic immediate=
ly
>> upon detecting the first hung task=2E However, some hung tasks are tran=
sient
>> and the system can recover fully, while others are unrecoverable and
>> trigger consecutive hung task reports, and a panic is expected=2E
>>=20
>> This commit adds a new sysctl parameter hung_task_count_to_panic to all=
ows
>> specifying the number of consecutive hung tasks that must be detected

Why make a new sysctl? Can't you just use hung_task_panic and raise the ma=
x to INT_MAX?

-Kees

>> before triggering a kernel panic=2E This provides finer control for
>> environments where transient hangs maybe happen but persistent hangs sh=
ould
>> still be fatal=2E
>>=20
>> Acked-by: Lance Yang <lance=2Eyang@linux=2Edev>
>> Signed-off-by: Li RongQing <lirongqing@baidu=2Ecom>
>> ---
>> Diff with v1: change documentation as Lance suggested
>>=20
>>  Documentation/admin-guide/sysctl/kernel=2Erst |  8 ++++++++
>>  kernel/hung_task=2Ec                          | 14 +++++++++++++-
>>  2 files changed, 21 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/Documentation/admin-guide/sysctl/kernel=2Erst b/Documentat=
ion/admin-guide/sysctl/kernel=2Erst
>> index 8b49eab=2E=2E98b47a7 100644
>> --- a/Documentation/admin-guide/sysctl/kernel=2Erst
>> +++ b/Documentation/admin-guide/sysctl/kernel=2Erst
>> @@ -405,6 +405,14 @@ This file shows up if ``CONFIG_DETECT_HUNG_TASK`` =
is enabled=2E
>>  1 Panic immediately=2E
>>  =3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>> =20
>> +hung_task_count_to_panic
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>The underline length should be at least as long as the title to
>prevent kernel-doc build warnings=2E Same length is preferred=2E
>
>> +
>> +When set to a non-zero value, a kernel panic will be triggered if the
>> +number of detected hung tasks reaches this value=2E
>> +
>> +Note that setting hung_task_panic=3D1 will still cause an immediate pa=
nic
>> +on the first hung task=2E
>> =20
>>  hung_task_check_count
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>

--=20
Kees Cook

