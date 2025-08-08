Return-Path: <linux-kernel+bounces-759693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED834B1E12C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 06:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D847A18A2AAC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 04:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107D81990B7;
	Fri,  8 Aug 2025 04:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cefhYgqv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746BF367
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 04:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754626463; cv=none; b=n7tc9Vpai18iMFdmU8w40RL3KzXEIepBf8VjmlaeEEQIESL5PvXBXy+WtrOUt+tJmWqefgsvu0iF9/C3K/JcXSASWee6wSU1wqUDtJYXuJP8BKd/Aqwf3LnzZSBAS6qiz82stFKliTr1LimW53Dp76rkch1f9HBdeWZ7S6NNKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754626463; c=relaxed/simple;
	bh=qwItsFMa5Kny4Eyf0BZSWka4fDemBGqbeTxFKDyzF4g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cgvxNE2CcjW6zR7f2MhYigvRP94Gh/p4ayWyJDrz3bHiyfFXTsWHMvkVwJAxinqOugDz3J0rz2OPcEVg8dg+OJOGoiEEa9Qcf0UHRcCT2P+m6H6zHTZgn4VncHJ5EnoJNsq1X5lILjuvZVTKEyWSIMKXnjXDzNOdeonDW5xnUWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cefhYgqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E66C4CEF0;
	Fri,  8 Aug 2025 04:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754626463;
	bh=qwItsFMa5Kny4Eyf0BZSWka4fDemBGqbeTxFKDyzF4g=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=cefhYgqvhjIpva0JgTGw439CdjsWRREGzopAdDBjKayN/+R+qMZlL65J+sZ5KDdH7
	 EPFOgpKeIitMDBH9qsE88CuhcFz8BfmxpLuTlBLWaogA70iyWvxMYPNvRP25tpEAi9
	 qP7clfynnZAj5WuPPwMFc/ruQ3F2ps7c+1yS7rQ/V/GTM/1k01mlUFsptC4vyyZ2md
	 Dcoe2osedqi9VLULO6lpTRGF8pv5gebuGTvqfCWTylL97k2rNFyITti8rhfGk0ic/V
	 pV8mdAuNE9Up1beOrVek80bqYIeBgGds2ZDrkdPftIHrHmKnTHrUdRRdjpYv/eN16q
	 Mrd8dg87d+VoQ==
Message-ID: <b8470c47-4fc2-48da-b93d-cb469638fb43@kernel.org>
Date: Fri, 8 Aug 2025 12:14:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to clear unusable_cap for
 checkpoint=enable
To: Zhiguo Niu <niuzhiguo84@gmail.com>
References: <20250807014836.3780988-1-chao@kernel.org>
 <CAHJ8P3Krr4pCdOmnSJ6mp5bfGLLH4TJqd0FC7Qiw2V3iEL5VEw@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3Krr4pCdOmnSJ6mp5bfGLLH4TJqd0FC7Qiw2V3iEL5VEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/8/2025 9:07 AM, Zhiguo Niu wrote:
> Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
> 于2025年8月7日周四 09:52写道：
>>
>> mount -t f2fs -o checkpoint=disable:10% /dev/vdb /mnt/f2fs/
>> mount -t f2fs -o remount,checkpoint=enable /dev/vdb /mnt/f2fs/
>>
>> kernel log:
>> F2FS-fs (vdb): Adjust unusable cap for checkpoint=disable = 204440 / 10%
>>
>> If we has assigned checkpoint=enable mount option, unusable_cap{,_perc}
>> parameters of checkpoint=disable should be reset, then calculation and
>> log print could be avoid in adjust_unusable_cap_perc().
>>
>> Fixes: 1ae18f71cb52 ("f2fs: fix checkpoint=disable:%u%%")
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/super.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index f37004780ce0..c1f45df9efec 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1014,6 +1014,10 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>>                          ctx_set_opt(ctx, F2FS_MOUNT_DISABLE_CHECKPOINT);
>>                          break;
>>                  case Opt_checkpoint_enable:
>> +                       F2FS_CTX_INFO(ctx).unusable_cap_perc = 0;
>> +                       ctx->spec_mask |= F2FS_SPEC_checkpoint_disable_cap_perc;
>> +                       F2FS_CTX_INFO(ctx).unusable_cap = 0;
>> +                       ctx->spec_mask |= F2FS_SPEC_checkpoint_disable_cap;
> Hi Chao,
> when enable checkpoint, shoud it be:
> ctx->spec_mask &= ~F2FS_SPEC_checkpoint_disable_cap_perc;
> ctx->spec_mask &= ~F2FS_SPEC_checkpoint_disable_cap;
> please correct me if I misunderstanding.

Zhiguo,

IMO, F2FS_SPEC_checkpoint_disable_cap_perc or F2FS_SPEC_checkpoint_disable_cap
flags can be added to ctx->spec_mask to indicate ctx.unusable_cap_perc or
ctx.unusable_cap has been updated, then we can store last parameter value from
ctx to sbi in f2fs_apply_options() as below:

	if (ctx->spec_mask & F2FS_SPEC_checkpoint_disable_cap)
		F2FS_OPTION(sbi).unusable_cap = F2FS_CTX_INFO(ctx).unusable_cap;
	if (ctx->spec_mask & F2FS_SPEC_checkpoint_disable_cap_perc)
		F2FS_OPTION(sbi).unusable_cap_perc =
					F2FS_CTX_INFO(ctx).unusable_cap_perc;

Or am I missing something here?

Thanks,

> thanks!
>>                          ctx_clear_opt(ctx, F2FS_MOUNT_DISABLE_CHECKPOINT);
>>                          break;
>>                  default:
>> --
>> 2.49.0
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


