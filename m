Return-Path: <linux-kernel+bounces-802570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52560B453EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372583B2EA6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA89D29C344;
	Fri,  5 Sep 2025 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="bZ1rKPju"
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97DB299959;
	Fri,  5 Sep 2025 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=157.107.129.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757066409; cv=pass; b=PKxAA3qaQ2UwKZqc2fH+kL6vTBqUn1GE2bDVRzuQU2TaqdEWE9trzRdgJ6SId60pfqwx2vwxUlKjEIj50OeDSw9ka8wQHxxCUPVVEeAgz3oykL6YfeU/ZDC1fqb+9blyKJrKiFxEa0/XqsifdRls17V5o9DFGpdxkVYvwh/kSlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757066409; c=relaxed/simple;
	bh=//E6VuckYvFeQEKYG5UGFWm9/s4L4UbMW/5I7jgdka8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=hsu/FLvyWQj/GX3vdLrFdDsxTFVZ+xi20KYFM3LdoumO0QgZA0u7mPFkaQsL4LFqUUTegVZtu2/0JzzpjY6HawmZ6f4Meu5+Id8PZK8jgwIVwQwEftoQdmhco/b1TaB+rFYuwK8Xtpf8/+HbQdDNJHHU+lC342NN2yRUrHev2NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=bZ1rKPju; arc=pass smtp.client-ip=157.107.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id EF0A1109D5675;
	Fri,  5 Sep 2025 18:59:06 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NYVS74ahHZTi; Fri,  5 Sep 2025 18:59:02 +0900 (JST)
Received: from webmail.redadmin.org (redadmin.org [192.168.11.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: weibu@redadmin.org)
	by www.redadmin.org (Postfix) with ESMTPSA id DF6AD109EFCDE;
	Fri,  5 Sep 2025 18:59:01 +0900 (JST)
DMARC-Filter: OpenDMARC Filter v1.4.2 www.redadmin.org DF6AD109EFCDE
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=192.168.11.50
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757066342;
	cv=none; b=YL6tgkaBt1LxeWphQps8FdRJQtEIbwOC5nl2H12TpywBHPelr0ymJvgLtLmZgyWmoIpjDydSVH4c5pZINjhTN87obDN49KRCFVJPlTpuYYkVKdU6NEtSKc85sEL25GsmOD1jYgU/aA25GFdhHNFspsggHiPTRdpPxlmg7N+vfPU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757066342; c=relaxed/relaxed;
	bh=rS61IeZT5rzeSXHAT1NTR7y9kJ8XX2rCqt+4Om7z2AI=;
	h=DKIM-Filter:DKIM-Signature:MIME-Version:Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding; b=zUOaAlKJJgVrOXzVwyGZ5iqS0sw9jFo90irHDaprz3lWXITBMm5gbbrmW58nNmYrmMo8VeQj4mQaWa5sOqRLmRRxbaPAOy1MtChv4MEF//XpABGSt1OsOQOvZA1uWLywS/zxUFWPlzMS4N288BpT2U5VgGt9vzHrbFsFEpfg/mY=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org DF6AD109EFCDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757066341;
	bh=rS61IeZT5rzeSXHAT1NTR7y9kJ8XX2rCqt+4Om7z2AI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bZ1rKPjua+ZPNAKTDRDJ172Q766XqoExWN+U/EWQLNygr3OX96knPCORlvJK1wwOu
	 x5R+KwP+zFOZPokYGuCVNZ7Ag8Ox7GyBeXv0QyU/PFCDdY/QOXGPjB9gObRYdrXBez
	 WznHYpOzfYOmDAIYpTd68RmZ+1fMH6VjqooClC9Y=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 05 Sep 2025 18:59:01 +0900
From: weibu@redadmin.org
To: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-kernel@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: ja_JP: add guidance for the Fixes: tag in
 SubmittingPatches
In-Reply-To: <cbcc3317-958c-450d-afab-e9a29b1d5add@gmail.com>
References: <20250905032729.2284883-1-weibu@redadmin.org>
 <cbcc3317-958c-450d-afab-e9a29b1d5add@gmail.com>
Message-ID: <8cb26ed070501f86a555cd5c525e113d@redadmin.org>
X-Sender: weibu@redadmin.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit



Hi Akira-san

Thanks—got it. I’ll take the middle ground you suggested.

For v2, I’ll cover both commits:

sync the “Fixes:” section and related wording from 8401aa1f5997, and

keep the example/pretty-format from 5b5bbb8cc51be.

I’ll keep v2 scoped to those hunks for an easier review. After that, I 
can follow up with a separate series to gradually sync the ja_JP file 
with the current English submitting-patches.rst.

Thanks,
Akiyoshi


2025-09-05 18:48 に Akira Yokosawa さんは書きました:
> Hi Akiyoshi,
> 
> On Fri,  5 Sep 2025 12:27:29 +0900, Akiyoshi Kurita wrote:
>> The Japanese translation of SubmittingPatches was missing the section
>> describing the use of the 'Fixes:' tag. This patch adds the missing
>> description, aligning the translation with commit 8401aa1f5997
>> ("Documentation/SubmittingPatches: describe the Fixes: tag") in the
>> English version.
>> 
>> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
>> ---
> 
> This one made my imbox. Nice!
> 
>>  .../translations/ja_JP/SubmittingPatches      | 21 
>> +++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>> 
>> diff --git a/Documentation/translations/ja_JP/SubmittingPatches 
>> b/Documentation/translations/ja_JP/SubmittingPatches
>> index 5334db471744..28ad83171252 100644
>> --- a/Documentation/translations/ja_JP/SubmittingPatches
>> +++ b/Documentation/translations/ja_JP/SubmittingPatches
>> @@ -132,6 +132,27 @@ http://savannah.nongnu.org/projects/quilt
>>         platform_set_drvdata(), but left the variable "dev" unused,
>>         delete it.
>> 
>> +特定のコミットのバグを修正するパッチの場合（例：``git bisect``で問題を発見した場合）、
>> +少なくとも SHA-1 ID の最初の 12 文字と 1 行の要約を記載した「Fixes:」タグを使用してください。
>> +タグを複数行に分割しないでください。解析スクリプトを簡素化するため、タグは
>> +「75 文字で折り返す」ルールから除外されます。
>> +
>> +例:
>> +
>> +        Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() 
>> return the number of pages it actually freed")
>> +
>> +以下の ``git config`` 設定を使用すると、``git log`` や ``git show`` コマンドで
>> +上記形式を出力する際にプリティフォーマットを追加できます::
>> +
>> +        [core]
>> +                abbrev = 12
>> +        [pretty]
>> +                fixes = Fixes: %h (\"%s\")
>> +
>> +呼び出し例::
>> +
>> +        $ git log -1 --pretty=fixes 54a4f0239f2e
>> +        Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() 
>> return the number of pages it actually freed")
>> 
>>  3) パッチの分割
>> 
> 
> So, this doesn't cover the other hunks in commit 8401aa1f5997.
> Instead, it includes the change made later in commit 5b5bbb8cc51be
> ("docs: process: Add an example for creating a fixes tag").
> 
> Your interpretation of Jon's desire might be different from that of
> mine, but I think Jon suggested translating up-to-date
> submitting-patches.rst as a whole.
> 
> Of course that would be great, but I'm not sure it is a reasonable ask
> here.
> 
> I think covering both commits 8401aa1f5997 and 5b5bbb8cc51be might be
> a reasonable middle ground here.
> 
> What do you think?
> 
> It's 100% up to you how far you want to do.
> 
> Thanks, Akira

