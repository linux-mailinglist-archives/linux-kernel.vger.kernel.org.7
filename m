Return-Path: <linux-kernel+bounces-882457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D57DC2A817
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 09:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A83443463D4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 08:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1AC2D249A;
	Mon,  3 Nov 2025 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0YNXVS0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA12C0282
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157540; cv=none; b=AVwOw1Sc+BJhN+96Wf1vOQqcctpDv3ScvKbwOmexeP1Zwdr43cjM1dq+UvX9htGPSA2hA8nwACUpMmXG7tntk2EQu3OnBaC8Ts9riWYcnB5auF0If/hlmA1RdLFDKtjk0tuIEUcX9Dz0wOZzYR1pfIrayJ6Xm9hNKiKUf5m5iQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157540; c=relaxed/simple;
	bh=IvpnIGpW5pDCkLQfXgWwGHkEHfCk7MiqPLCNiRLC+WQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bidm4QE4qcH+WHXSdVyfAJVmVY2r/MNB7bD1UWuvs269HWW1RvXCHsgFYJG9/1/uyPrcOpMn5Q7JG8rt12IgsYrBgzUvMWnxD1PbawPd0Ly5Se6v34yT40BkT8k4fM3U8XCshtpquYDPDZDgsFVdhhbQoTX5SnNeXmMMpZnwXII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0YNXVS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D6AC4CEE7;
	Mon,  3 Nov 2025 08:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762157539;
	bh=IvpnIGpW5pDCkLQfXgWwGHkEHfCk7MiqPLCNiRLC+WQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=S0YNXVS0yAj8eMy8n4ZhbtQ9hC9T7Mf54lpwHTVpoKAAqh3V3nd+ZzZVWHv1SV+W5
	 UAd3gtBHUvErsl25wSglSV94+e8eDBDB8+xMxyHLV58f0Sqe6lPn/TWLtxh6scepw4
	 q1spY+AuYY/hk7wOUS7giLwwNUxKshkly3d98vZcRt5zCD8YKe0Uuttbl/D5MsOzbi
	 m7k5AUlzhk2nB/mr+GfQBTZnFtjo5imn3No8h0N+RqcIbXSniKdUZO5aitu2TIC4Pn
	 8uCvFmJpzDoQRIseKnwWF1P6pLD5ClaNqTQC1KpNUhsTxWbg3yaBpYQf1kguBZhJa1
	 7oUS76waCD/vQ==
Message-ID: <1f519357-a489-41fe-8159-a8e319aedd17@kernel.org>
Date: Mon, 3 Nov 2025 16:12:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org, khalid@kernel.org,
 syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 2/2] f2fs: Add sanity checks before unlinking and
 loading inodes
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
References: <cover.1761993022.git.zlatistiv@gmail.com>
 <55522ef8f3424e563ff18a720c709dcb065091af.1761993022.git.zlatistiv@gmail.com>
 <ea38e464-a28a-4b06-8046-5b62f7172875@kernel.org>
 <pcxf66ac2yjkqyvhb6xgbk6jiihcejuncgbblkewz6rs7i5uzt@m6yjin7t67is>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <pcxf66ac2yjkqyvhb6xgbk6jiihcejuncgbblkewz6rs7i5uzt@m6yjin7t67is>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/25 15:55, Nikola Z. Ivanov wrote:
> On Mon, Nov 03, 2025 at 10:35:17AM +0800, Chao Yu wrote:
>> On 11/1/25 20:56, Nikola Z. Ivanov wrote:
>>> Add check for inode->i_nlink == 1 for directories during unlink,
>>> as their value is decremented twice, which can trigger a warning in
>>> drop_nlink. In such case mark the filesystem as corrupted and return
>>> from the function call with the relevant failure return value.
>>>
>>> Additionally add the 2 checks for i_nlink == 0 and i_nlink == 1 in
>>> sanity_check_inode in order to detect on-disk corruption early.
>>>
>>> Reported-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=c07d47c7bc68f47b9083
>>> Tested-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
>>> Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
>>> ---
>>>  fs/f2fs/inode.c | 10 ++++++++++
>>>  fs/f2fs/namei.c | 15 +++++++++++----
>>>  2 files changed, 21 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>>> index 8c4eafe9ffac..089cbf3646f0 100644
>>> --- a/fs/f2fs/inode.c
>>> +++ b/fs/f2fs/inode.c
>>> @@ -294,6 +294,16 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
>>>  		return false;
>>>  	}
>>>  
>>> +	if (unlikely(inode->i_nlink == 0)) {
>>
>> This is a possible case, as an orphan inode may exist in filesystem after sudden
>> power-cut.
>>
>> Thanks,
>>
> 
> Hi Chao,
> 
> Do you suggest that it should not be wrapped in unlikely()?

Nikola,

No, I think we should not add this sanity check "inode->i_nlink == 0"
into sanity_check_inode(), as for an orphan inode, its i_nlink is zero.
We expect to get the inode w/o failure in recover_orphan_inode().

> 
> I also now realise that I intended to wrap the "else if" case
> as well but I've missed it in the final patch.

Looks fine to add unlike for the "dir->i_nlink == 1" case.

Thanks,

> 
> Should I resend the patch with both cases wrapped in "unlikely()"
> or would you suggest otherwise?
> 
> 
>>> +		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
>>> +			  __func__, inode->i_ino);
>>> +		return false;
>>> +	} else if (S_ISDIR(inode->i_mode) && inode->i_nlink == 1) {
>>> +		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
>>> +			  __func__, inode->i_ino);
>>> +		return false;
>>> +	}
>>> +
>>>  	if (f2fs_has_extra_attr(inode)) {
>>>  		if (!f2fs_sb_has_extra_attr(sbi)) {
>>>  			f2fs_warn(sbi, "%s: inode (ino=%lx) is with extra_attr, but extra_attr feature is off",
>>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>>> index 40cf80fd9d9a..d13077bad482 100644
>>> --- a/fs/f2fs/namei.c
>>> +++ b/fs/f2fs/namei.c
>>> @@ -572,10 +572,11 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>>>  	if (unlikely(inode->i_nlink == 0)) {
>>>  		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
>>>  			  __func__, inode->i_ino);
>>> -		err = -EFSCORRUPTED;
>>> -		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
>>> -		f2fs_folio_put(folio, false);
>>> -		goto out;
>>> +		goto corrupted;
>>> +	} else if (S_ISDIR(inode->i_mode) && inode->i_nlink == 1) {
>>> +		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
>>> +			  __func__, inode->i_ino);
>>> +		goto corrupted;
>>>  	}
>>>  
>>>  	f2fs_balance_fs(sbi, true);
>>> @@ -601,6 +602,12 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>>>  
>>>  	if (IS_DIRSYNC(dir))
>>>  		f2fs_sync_fs(sbi->sb, 1);
>>> +
>>> +	goto out;
>>> +corrupted:
>>> +	err = -EFSCORRUPTED;
>>> +	set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
>>> +	f2fs_folio_put(folio, false);
>>>  out:
>>>  	trace_f2fs_unlink_exit(inode, err);
>>>  	return err;
>>


