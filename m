Return-Path: <linux-kernel+bounces-883642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DFCC2DF53
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 21:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29BCE3BCF57
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 20:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307F323EA80;
	Mon,  3 Nov 2025 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlWmdhJ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775501F9F70
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762200069; cv=none; b=Toq84LLRnz/8JR9fFR/bH6VdCpxPFn0oMyuc25bBuIAiPVTbh/ZPA2ndsSrnfiabBORV6sxHoISewYm6DZp52QZskR+AeOVEp8dknZLcDodnNsvXeVpR05eQkFDbbz0jWAUteyYfXD3AUrLxBgUb12lkqNOle/zsW6106csBx6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762200069; c=relaxed/simple;
	bh=0/35UyEV2qxPuhoWGblSRot/TIt5XqNbKGc450yCEt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efPnOHUKXET+l+8crCaEHoTLSWnJ/C2jlfr3+XJnyDzzALjNh3t+QsJtdWOaAlzn4CprtKGnO/S2qeflqdKv/veG0Z83JpwkttE4sFyHoTG2IPayvRvWERjd+bxUX5sSJOKqvBqeH+HZ28ktarTRl912ueqzdWUKf9zq5JykdT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlWmdhJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722F7C4CEE7;
	Mon,  3 Nov 2025 20:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762200069;
	bh=0/35UyEV2qxPuhoWGblSRot/TIt5XqNbKGc450yCEt0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OlWmdhJ1/f5xyqn8eu/j40QYsrPYsFmbQr3aAvJU+Yax4mvgjtfHcgXUlqEo8OlJ0
	 /YxyVwDVO/WlXbKHGH8jOgjS2AcStSpU4G4VTR1SSq9Aa220luRE01MHCjBozWzaby
	 lhypN1NZP8VG2mMa34+D+EUgV2FuZKKQz0H7Ss6UFZ3e2Zd13Dzc2MXmPB/4fTGBWk
	 YCpExWYZ/3o8c9NlrNJSZnweNURCdrQpGj3LL6qgEQ6q2yUOhafWTT73VO2wAb8WPC
	 8pnTxGhnwuLjyp39l364hu2rHyqjYuRWllz+d9Z/BC3jxHGSpAh1kWXhninc13HUxP
	 TGZYM7Ig2K2Xw==
Message-ID: <7768bbb5-f060-45f7-b584-95bd73c47146@kernel.org>
Date: Mon, 3 Nov 2025 21:01:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] mm/userfaultfd: modulize memory types
To: Peter Xu <peterx@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Nikita Kalyazin <kalyazin@amazon.com>,
 Vlastimil Babka <vbabka@suse.cz>, Axel Rasmussen <axelrasmussen@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 James Houghton <jthoughton@google.com>, Hugh Dickins <hughd@google.com>,
 Michal Hocko <mhocko@suse.com>, Ujwal Kundur <ujwal.kundur@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Suren Baghdasaryan <surenb@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>, conduct@kernel.org
References: <20251014231501.2301398-1-peterx@redhat.com>
 <78424672-065c-47fc-ba76-c5a866dcdc98@redhat.com> <aPZDVuscFsYSlQjI@x1.local>
 <dtepn7obw5syd47uhyxavytodp7ws2pzr2yuchda32wcwn4bj4@wazn24gijumu>
 <aPe0oWR9-Oj58Asz@x1.local>
 <nnxhd7zxjza6m4w4lr5qyev2krbkp4yfcgcwq6nkaqrqt6bzpb@iklep2xxp5gv>
 <aQO3Zko6Qrk7O96u@x1.local> <aQPCwFZqNd_ZlZ0S@x1.local>
 <d0b037a6-11b9-483b-aa67-b2a8984e56e0@lucifer.local>
 <aQPU-tyo_w68cnKK@x1.local>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <aQPU-tyo_w68cnKK@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> I have an extremely heavy workload at the moment anyway, but honestly
>> interactions like this have seriously put me off being involved in this review
>> personally.
>>
>> Do we really want this to be how review in mm or the kernel is?
>>
>> Is that really the culture we want to have here?
> 
> Gosh.. Seriously?
> 
> I'm ok if this needs to be audited.  I have all the previous discussions in
> the cover letter as links.

I'm late to the party (or whatever this here is called. ah right, 
drama), and I haven't yet dug through all the emails and certainly not 
through all the of involved code changes.

Peter, I was a bit surprised by your messages here indeed, not what I 
expected.

The "Your code allows to operate on pmd* in a module??? That's too risky 
and mm can explode!  Isn't it?" definitely was absolutely unnecessary 
... or telling Liam that "he want almost mad".

Again, not what I would have expected from you, and I would assume that 
you had a bad day and would at least apologize now that some time passed.

I understand that you were upset by the previous feedback on the earlier 
series.

There were some heated arguments in the last discussions, but most of 
them were based on misunderstandings. I would have thought that once 
they were resolved that we could continue focusing on discussing the 
technical details again.

 From what I can see you asked for actual code and when Liam came back 
with some code that looks like *a lot of work* to me.

He really seems to care (which I highly appreciate) and went the extra 
mile to show us how the uffd code could evolve.

We've all (well okay, some of us) been crying for some proper 
userfaultfd cleanups for years.

So is there a way we can move forward with this without thinking in 
binary? Is there some middle-ground to be had? Can some reworks come on 
top of your series? Can so reworks be integrated in this series?

I agree that what Liam proposes here is on the larger side, and probably 
does a lot of things in a single rework. That doesn't mean that we 
couldn't move into that direction in smaller steps.


(I really don't think we should be thinking in terms of a CoC war like: 
show them what I did and I will show them what they did. We are all 
working on the same bigger goal here after all ...)

-- 
Cheers

David

