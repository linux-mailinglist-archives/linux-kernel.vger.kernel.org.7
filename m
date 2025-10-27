Return-Path: <linux-kernel+bounces-870829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0D6C0BC6F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F8D3B754C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 04:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4059A2D4803;
	Mon, 27 Oct 2025 04:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="m44zZM76"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED1319E968;
	Mon, 27 Oct 2025 04:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761539163; cv=pass; b=jvfsoxnvKiwflzhOTOAnUCd5FrQLT4nxAbQPCUIIoWs5Zb7N4c06bihME3iEqtVJXFF2oIVt4b4P+be8GWEO7NGMFkj0tCmhi9u779IbaoXOPI1cQ9rAcvRto/E4i3C3WA8lvWseirqWyXp0wzDXVjcaLls7k29MiTvWYaEAKTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761539163; c=relaxed/simple;
	bh=DNYt74eYYd/1J6KyF4fbjIzMPBtQOkvmUXn/mGVFdVg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JoBjeGZqS9rkExlH5yu7GFd0BjRBwjTeeOTmqtPC0dsHjzWmF/i2+pQ0crFbX97qh3xWTn0tOU+a5HQm6UdUfjRmdDdkG4FKnDvk7/7hVZUazBA8TkRwhgRs/tTK0T0VjfJgXwrLxa3Pq69m/iG/L5DKDwAUNWRABllsOVGBX9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=m44zZM76; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (bc043154.ppp.asahi-net.or.jp [222.228.43.154])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59R4PhKZ038724
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 27 Oct 2025 13:25:43 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 81A5E106E791A;
	Mon, 27 Oct 2025 13:25:42 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Llbg0nhPWc9r; Mon, 27 Oct 2025 13:25:37 +0900 (JST)
Received: from webmail.redadmin.org (redadmin.org [192.168.11.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: weibu@redadmin.org)
	by www.redadmin.org (Postfix) with ESMTPSA id 4FB19106E7917;
	Mon, 27 Oct 2025 13:25:37 +0900 (JST)
DMARC-Filter: OpenDMARC Filter v1.4.2 www.redadmin.org 4FB19106E7917
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=192.168.11.50
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1761539137;
	cv=none; b=u0+ubl/O7lYkOm264kw/TYz4DGhtpkaZcIoGa5SVywA4npDm7cWsgIpkhW6XJebM5+0mDcNW/K5PLJI6mD509ns84AVCafoM53CaFBmyOeD3pxlqa12enaLOoBTXqewZzdaOr54ZfIfoGjwpGu9RUkEOGo9eUT4lHOzK0jOrHwc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1761539137; c=relaxed/relaxed;
	bh=rEuEFpJaqguTP6zBfsgvlVykQOT8EAPojPlj+YAPv1Q=;
	h=DKIM-Filter:DKIM-Signature:MIME-Version:Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding; b=UH4nZe6COg4AxMqpCKvTPiqh62EhC/i2WlTN2MNVvLsmjkOabKJoyFtaPM+ViArnHs7Azp5pWla8eO/M9yhfb5QauQwuCsYxLp5mfEFlFkWaXuR2992PnFh9GNa0eb78xsaldhpLHDk8wNnfiIiQrSF9i5wHUG9hXV8xTsZ3e2k=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 4FB19106E7917
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1761539137;
	bh=rEuEFpJaqguTP6zBfsgvlVykQOT8EAPojPlj+YAPv1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m44zZM76V/a9njukwvMQv85rxm1+DYEE7Yfr4AjUxH4H29c2nCOHdbokYjIxYebMS
	 JdRdsABxtpQdIHq/1jVjgeZbV/JV9z4JkA9QfX+2ubU6NYRvyqplz0GezrrWTNGAb5
	 /hz8znqgajQOVoBYt87u0wSscamJt0uOKgqp0GuY=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 27 Oct 2025 13:25:37 +0900
From: weibu@redadmin.org
To: Akira Yokosawa <akiyks@gmail.com>
Cc: corbet@lwn.net, shibata@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Subject: [PATCH] docs: ja_JP: Move submitting-patches to
 process/ and add to build
In-Reply-To: <67d1cfd2-a3e3-4a3f-89f5-38e822321578@gmail.com>
References: <20251024235437.801625-1-weibu@redadmin.org>
 <67d1cfd2-a3e3-4a3f-89f5-38e822321578@gmail.com>
Message-ID: <1a97317518d8dcd7d5f0aea898e21f09@redadmin.org>
X-Sender: weibu@redadmin.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hi Akira-san,

Thank you for the detailed review. I will work on a v2 patch based on 
your suggestions.

Thanks, Akiyoshi Kurita


2025-10-27 11:53 に Akira Yokosawa さんは書きました:
> Hi Kurita-san,
> 
> Thank for your continued work on this!
> 
> On Sat, 25 Oct 2025 08:54:37 +0900, Akiyoshi Kurita wrote:
>> As requested by Jonathan, move the Japanese translation of
>> 'SubmittingPatches' to its proper location under 'process/' and
>> convert it to reStructuredText.
> 
> In https://lore.kernel.org/87jz0xbk6f.fsf@trenco.lwn.net/, Jon said:
> 
>>> That said ... this is not an RST file, and won't be pulled into the 
>>> docs
>>> build.  I would *love* to see a patch that moves this file into its
>>> proper location under .../process/ and brings it into the build.
> 
> This patch does the *minimal* thing, namely the rename of the file,
> with minor changes near the top of the doc.
> 
> Yes, the resulting .rst doesn't cause any *new* warnings from Sphinx,
> but looking at the resulting HTML (or PDF), I don't think the rendered
> page looks nice.
> 
> I'm wondering if this is what Jon would love to see. (Well, Jon doesn't
> read Japanese and would not mind.)
> 
> Of course, I understand you are going to do both translation and reST 
> markup
> updates as follow-up changes.  But I'd rather refrain from exposing
> work-in-progress doc in the translations docs.
> 
> Please read on in-line comments below:
> 
>> 
>> This patch also wires the new file into the Japanese documentation's
>> toctree, allowing it to be included in the Sphinx build.
>> 
>> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
>> ---
>>  Documentation/translations/ja_JP/index.rst    |  1 +
>>  .../submitting-patches.rst}                   | 61 
>> ++++++++++---------
>>  2 files changed, 32 insertions(+), 30 deletions(-)
>>  rename Documentation/translations/ja_JP/{SubmittingPatches => 
>> process/submitting-patches.rst} (96%)
>> 
>> diff --git a/Documentation/translations/ja_JP/index.rst 
>> b/Documentation/translations/ja_JP/index.rst
>> index 4159b417bfdd..8e01619d4170 100644
>> --- a/Documentation/translations/ja_JP/index.rst
>> +++ b/Documentation/translations/ja_JP/index.rst
>> @@ -11,6 +11,7 @@
>>  .. toctree::
>>     :maxdepth: 1
>> 
>> +   process/submitting-patches
> 
> This should come below process/howto. Still, as I said above, I think 
> this
> addition is premature.  One option would be to put a fat warning at the 
> top
> of the doc saying "This section is work-in-progress!!", or so.
> 
>>     disclaimer-ja_JP
>>     process/howto
>>     process/submit-checklist
>> diff --git a/Documentation/translations/ja_JP/SubmittingPatches 
>> b/Documentation/translations/ja_JP/process/submitting-patches.rst
>> similarity index 96%
>> rename from Documentation/translations/ja_JP/SubmittingPatches
>> rename to 
>> Documentation/translations/ja_JP/process/submitting-patches.rst
>> index b950347b5993..4bfa84cc705d 100644
>> --- a/Documentation/translations/ja_JP/SubmittingPatches
>> +++ b/Documentation/translations/ja_JP/process/submitting-patches.rst
>> @@ -1,33 +1,34 @@
>> -NOTE:
>> -This is a version of Documentation/process/submitting-patches.rst 
>> into Japanese.
>> -This document is maintained by Keiichi KII <k-keiichi@bx.jp.nec.com>
>> -and the JF Project team <http://www.linux.or.jp/JF/>.
>> -If you find any difference between this document and the original 
>> file
>> -or a problem with the translation,
>> -please contact the maintainer of this file or JF project.
>> -
>> -Please also note that the purpose of this file is to be easier to 
>> read
>> -for non English (read: Japanese) speakers and is not intended as a
>> -fork. So if you have any comments or updates of this file, please try
>> -to update the original English file first.
>> -
>> -Last Updated: 2011/06/09
>> -
>> -==================================
>> -これは、
>> -linux-2.6.39/Documentation/process/submitting-patches.rst の和訳
>> -です。
>> -翻訳団体： JF プロジェクト < http://www.linux.or.jp/JF/ >
>> -翻訳日： 2011/06/09
>> -翻訳者： Keiichi Kii <k-keiichi at bx dot jp dot nec dot com>
>> -校正者： Masanari Kobayashi さん <zap03216 at nifty dot ne dot jp>
>> -         Matsukura さん <nbh--mats at nifty dot com>
>> -         Takeshi Hamasaki さん <hmatrjp at users dot sourceforge dot 
>> jp>
>> -==================================
>> -
>> -        Linux カーネルに変更を加えるための Howto
>> -        又は
>> -        かの Linus Torvalds の取り扱い説明書
>> +..
>> +   NOTE:
>> +     This is a version of 
>> Documentation/process/submitting-patches.rst into Japanese.
>> +     This document is maintained by Keiichi KII 
>> <k-keiichi@bx.jp.nec.com>
>> +     and the JF Project team <http://www.linux.or.jp/JF/>.
>> +     If you find any difference between this document and the 
>> original file
>> +     or a problem with the translation,
>> +     please contact the maintainer of this file or JF project.
>> +
>> +     Please also note that the purpose of this file is to be easier 
>> to read
>> +     for non English (read: Japanese) speakers and is not intended as 
>> a
>> +     fork. So if you have any comments or updates of this file, 
>> please try
>> +     to update the original English file first.
>> +
>> +     Last Updated: 2011/06/09
>> +
>> +     ==================================
>> +     これは、
>> +     linux-2.6.39/Documentation/process/submitting-patches.rst の和訳
>> +     です。
>> +     翻訳団体： JF プロジェクト < http://www.linux.or.jp/JF/ >
>> +     翻訳日： 2011/06/09
>> +     翻訳者： Keiichi Kii <k-keiichi at bx dot jp dot nec dot com>
>> +     校正者： Masanari Kobayashi さん <zap03216 at nifty dot ne dot jp>
>> +           Matsukura さん <nbh--mats at nifty dot com>
>> +           Takeshi Hamasaki さん <hmatrjp at users dot sourceforge dot 
>> jp>
>> +     ==================================
> 
> This historic contribution record can be removed.  The same happened in
> howto.rst when Shibata-san did the conversion in commit f012733894d3
> ("Documentation: Add HOWTO Japanese translation into rst based build
> system").
> 
> Instead, please put a translation note referencing the disclaimer
> under the document title as is done in (ja_JP's) howto.rst and
> submit-checklist.rst.
> 
>> +
>> +========================================
>> +Linux カーネルに変更を加えるための Howto
>> +========================================
> 
> Title of the original now reads:
> 
>   Submitting patches: the essential guide to getting your code into the 
> kernel
> 
> Back in 2005, it read:
> 
>   How to Get Your Change Into the Linux Kernel
>           or
>   Care And Operation Of Your Linus Torvalds
> 
> And the Japanese translation has never had the title updated ...
> 
> Probably you can align the title with the current one.
> 
> As before, if you are not sure of the way to do, please ask me
> before submitting a next version.
> 
>         Thanks, Akira
> 
>> 
>>  Linux カーネルに変更を加えたいと思っている個人又は会社にとって、パッ
>>  チの投稿に関連した仕組みに慣れていなければ、その過程は時々みなさんを

