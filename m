Return-Path: <linux-kernel+bounces-884913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46717C317F8
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA333A9E45
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0662F3614;
	Tue,  4 Nov 2025 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7BzEF7o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D8320A0A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265929; cv=none; b=GUw6G/WCZlRLItL2XvebgLnqNGEDCuYdlLAlOPpweRYktAw7+Hi81lafDGiFolWsiVouBUPvmkeY9TTM2XC+m07nrD+j7jDIJkGvbqegW79r4casgZRzqAO0CP4Rg7f28r5HYkd3u/hFtwlb1Wqn/+4n8lzpanrzy56SnyrL4y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265929; c=relaxed/simple;
	bh=KDpA3sfTJje2PYGRTGef7NL8grPCiLnKO59C6WUsjEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sq+8etdzGwObYvc6Pjc7k50Su1ZhoU33sS/aAAs5d3slWoT4wqOpTd0vU5UudquVM9g5QNHBzSFlg90x9i/ca9n3ioe7UaH/Gssuade7eAL27C/lh2SmEbnX27JvN7SW+eR4nqngPuuB49dPZMrjoEHrnJe7XuANYJQVLfdhxhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7BzEF7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC05C4CEF7;
	Tue,  4 Nov 2025 14:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762265929;
	bh=KDpA3sfTJje2PYGRTGef7NL8grPCiLnKO59C6WUsjEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a7BzEF7osH2v9ARCYCeQ6HfKY9wZv7DLYeLSUfZwei3yXJNENy25KCPWcM3pgTFSD
	 xE2Pj0ciI8BfCpz1WzXoJz0Q6JzXphKOHe+8XhKFeGLXrETRofN1juogJEPHB8OWQC
	 GVQL78JoqQOiBXA/1kyBr3zl1oJXnZH3UeaUkVlJYwWy7KcDeGptzRjawURSh/MqZo
	 mLoot90VHA0GNjn+Bc/K7xXziFoeu+NqJt74JR+kP/lqxLEArgPC4VRCxGg+prNPDo
	 E3t7RzQLpzKMbxrkEIpoTidpmWEJxz1jveteipDOjPLKBjbXPK63FQwq4kojzbCENN
	 bQizyIqoEGIhw==
Message-ID: <56df0211-dccd-425f-9690-e2c0adb2160f@kernel.org>
Date: Tue, 4 Nov 2025 15:18:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] mm/userfaultfd: modulize memory types
To: Peter Xu <peterx@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Nikita Kalyazin <kalyazin@amazon.com>,
 Vlastimil Babka <vbabka@suse.cz>, Axel Rasmussen <axelrasmussen@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 James Houghton <jthoughton@google.com>, Hugh Dickins <hughd@google.com>,
 Michal Hocko <mhocko@suse.com>, Ujwal Kundur <ujwal.kundur@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Suren Baghdasaryan <surenb@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>, conduct@kernel.org
References: <dtepn7obw5syd47uhyxavytodp7ws2pzr2yuchda32wcwn4bj4@wazn24gijumu>
 <aPe0oWR9-Oj58Asz@x1.local>
 <nnxhd7zxjza6m4w4lr5qyev2krbkp4yfcgcwq6nkaqrqt6bzpb@iklep2xxp5gv>
 <aQO3Zko6Qrk7O96u@x1.local> <aQPCwFZqNd_ZlZ0S@x1.local>
 <d0b037a6-11b9-483b-aa67-b2a8984e56e0@lucifer.local>
 <aQPU-tyo_w68cnKK@x1.local> <7768bbb5-f060-45f7-b584-95bd73c47146@kernel.org>
 <aQkUwbx7Z4q1qcSB@x1.local> <5f128cbf-7210-42d9-aca1-0a5ed20928c2@kernel.org>
 <aQkxioBXJtPbuJJ-@x1.local>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <aQkxioBXJtPbuJJ-@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>> Again, not what I would have expected from you, and I would assume that you
>>>> had a bad day and would at least apologize now that some time passed.
>>>
>>> Sorry, no.  I won't apologize for that.  I was not fair treated, and now I
>>> think it's fair I at least make a joke.
>>
>> Peter, if you would tell me that I am going mad I would not be able to
>> understand that as a joke -- unless maybe if you add plenty of :) . :)
> 
> If it's a problematic use of the word "mad", it could be my English not my
> attitude.  I can easily say I'm mad at something when I'm not satisfied.
> I admit I'm not a native speaker.

I'll note that there is a difference between "going mad" and "getting 
mad". Many of us are not native-speakers, so this stuff can happen. We 
can explain that it was not our intention and move on.

> 
> But then, if you think "mad" is a bad word, how about:

The issue is when it gets personal, not the word itself.

I.e., calling code mad/trash vs. calling people mad/trash.

Could be that some userfaultfd code might be mad trash :)

> 
> https://lore.kernel.org/all/6odeeo7bgxgq4v6y3jercrriqyreynuelofrw6k6roh7ws5vy2@wyvx7uiztb5y/
> 
>          I'm happy to address changes, but I'm not happy to accept more
>          middleware and "it's not part of the patch set" to address any
>          problem as you push more trash into an already horrible code base.
> 
> I didn't raise CoC report for that.  

I don't think this is CoC material, but I am sure no expert on that.

> I was still trying to be technical on
> the whole discussion as much as I can do best.  Hence, my reply was:
> 
>          > I'm happy to address changes, but I'm not happy to accept more
>          > middleware and "it's not part of the patch set" to address any problem
>          > as you push more trash into an already horrible code base.
>          >
>          > We need to fix things too.
>          >
>          > So I'm fixing it.
> 
>          Let's wait for a 2nd opinion on the approaches.
> 
>          As I said, I'm OK if everyone likes your solution and if I'm the only one
>          NACKing it.  If we can support guest-memfd finally whoever adds that, it's
>          not so bad.
> 
> Is "trash" a better word than "mad"?

See above.

[...]

>>>
>>> It's Liam who stood out strongly pushing back what he at least used to be
>>> not familiar with.  This was, IMHO, rude.  It's ok to keep silent on some
>>> patchset that one isn't familiar.  It's ok to ask questions.  It's not ok
>>> to strongly push back without being extremely familiar with the code.
>>
>> /me am I a rude person? :( ;)
> 
> Frankly, I would trust that if you strongly NACK a series, then you should
> have good knowledge of the code base and the series you disagree.

Right, I didn't, I pushed back against some things in there to reduce 
the scope. Even if it would go upstream as is I could live with it. I 
don't really maintain the VMA pieces though, that this interacts with.

So maintainers that maintain related pieces (e.g., VMA) might have a 
stronger opinion on the interface than me.

> 
> If you didn't have enough knowledge and NACK some patchset without really
> knowing much better than the author, yes, IMHO I think it's rude too.

I'm usually careful with NACKs, I barely use them :)

> 
> If I did it, it's the same.  I will be the one to be rude.  It has nothing
> to do with who's doing it.
> 
> Like if I strongly push back whatever change in maple tree, I'll be rude.
> I never did, and I'll never do that.

Well, assume you maintain VMA handling and there are changes to the 
maple tree that would affect the VMA handling, sure you could push back 
against some interface changes without being an expert on the maple tree 
implementation.

That's how people push back against some rust changes without being an 
expert on rust ...

Anyhow, I agree that jumping in into something completely unrelated 
could be considered rude. I don't think this is the case with Liam and 
Lorenzo here, though. But that's just my personal take.

[...]

>> I acked your series for a reason: I think it is good enough to implement
>> that (as simple as possible), but I also have the feeling that we can do
>> much better in general.
> 
> "feeling" is not a good reason to block a series from landing.  

Right, but I didn't block it because of that. I merely pointed at the 
raised alternative.

> If you, or
> Liam, or anyone, has good proposal already, we can always consider it.

Yeah, that's what Liam ended up doing. Spending a lot of time to have a 
technical discussion to see how we can move forward.

> 
> The thing is I don't easily see a good proposal so far, it's non-trivial.
> 
> Meanwhile, the current v1-v4 I posted should be simply enough that even if
> one day someone wants to clean it up we can revert relevant changes and
> apply the cleanup idea on top, because the changeset needed to do the
> cleanup on top of v1-v4 of mine will be trivial.  It doesn't need to be
> blocked.
> 
> I mentioned too that I think userfaultfd code isn't the cleanest, for
> example, here:
> 
> https://lore.kernel.org/all/aQPX859LbBg5FmE8@x1.local/
> 
>          On Thu, Oct 30, 2025 at 04:24:46PM -0400, Liam R. Howlett wrote:
>          > Right, so the existing code a huge mess today and you won't fix
>          > anything, ever.
> 
>          IMHO fix is the wrong word.  Cleanup it is.  I agree the current
>          userfaultfd code isn't extremely easy to follow.
> 
> So I agree cleanups might help.

Good that we all seem to agree on that at least.

> 
> Liam explained his "vision" on how to cleanup.  I explained why it won't
> work, starting from:
> 
> https://lore.kernel.org/all/20250926211650.525109-1-peterx@redhat.com
> 
> At that time, the proposal was still:
> 
>          struct vm_uffd_ops hugetlb_uffd_ops = {
>                  .missing = hugetlb_handle_userfault,
>                  .write_protect = mwriteprotect_range,
>                  .minor = hugetlb_handle_userfault_minor,
> 
>                  .mfill_atomic = hugetlb_mfill_atomic_pte,
>                  .mfill_atomic_continue = ...
>                  .mfill_zeropage = ...
>                  .mfill_poison = ...
>                  .mfill_copy = NULL, /* For example */
>          };
> 
> Obviously, whoever proposed above hasn't looked at handle_userfaultfd() at
> all. That's also why I stopped commenting at that time, because it means
> who proposed it actually doesn't know the code well yet, and I don't
> necessarily need to comment on each line.  I explained from high level on
> why it's an overkill at that time.
> 
> It's fine to propose something being familiar or not with it, but again
> it's not fine to strongly pushback one series with such a proposal, and
> without the familiarity of the code base.

Again, see my reasoning above regarding interfaces. Don't get me wrong, 
I understand both sides here and I am personally also not a friend of 
hard pushback / NACKs, which is why I usually try to phrase stuff 
differently.

> 
>>
>>>
>>> I sincerely wished that works out.  As I said, then I'll properly review
>>> it, and then we build whatever we need on top.  I'm totally fine.  However
>>> it didn't go like that, the API is exactly what I pictured.  I prefer my
>>> proposal.  That's what I did: showing the difference when there're two
>>> proposals, and ask for a second opinion.
>>>
>>> It's not fair to put that on top of me to blame.  He's trying to justify
>>> he's correct.  It has nothing to do with me.  He can stop pushing back
>>> anytime.  He can keep proposing what he works on.  It's his decision, not
>>> mine.
>>
>> I would prefer if we can come to a conclusion instead of having people stop
>> pushing back and walking away.
> 
> Obviously people can walk away from either side.  It's not always that who
> push back things can walk away.
> 
> I'm nobody.  I don't mean I'll be walking away and I'm comparing that to
> Liam's walking away.  Liam is doing very well on maple trees (I didn't
> follow at all, but I'd trust that), while I'm pretty sure Linux will run as
> smooth if I walked away.  

Of course, I wouldn't say "nobody". But yeah, pretty much all of use 
could leave the kernel today and Linux would keep on running fine (at 
least for a while :) ).

> However IMHO this is not a reason at all to allow
> anyone randomly NACK on anything without good reasons, and without good
> knowledge base of what the patchset is touching.
> 
> Not to mention this is also not the 1st time it got strong NACK.  v2 was
> almost NACKed because I introduced a function that returns a folio*.

Yeah, I hate how this patch set evolved. I guess most of us do.

[...]

>>
>> Of course, I *could* make a decision, but that would likely involve that we
>> continue the discussion without this drama. But do people want that?
> 
> If you get my whole point, I was sincerely trying to collect 2nd opinions.
> 
> I can paste my reply once more here, for my attitude:
> 
> https://lore.kernel.org/all/aQPX859LbBg5FmE8@x1.local/

That was the mail that was IMHO absolutely appropriately phrased.

> 
> If you are talking about drama, just to mention I didn't raise a CoC report
> even if my code was evaluated as "trash".  IMHO, whoever reads these
> discussions likely wasted some part of one's time.  I don't want to waste
> time for whoever is going to audit this whole thing.

Again, calling code trash is not really CoC material but I might be wrong.

> 
> I left my opinion in maybe 1 hour after Liam shared his branch, that
> included having lunch.  I can glimpse ~1000 LOC as fast almost because what
> Liam proposed matched almost like what I can imagine.
> 
> Mike shared his opinion today.
> 
> You can definitely share yours after taking time to read about it.
> 
> We stuck here for months. So many things happened.  It's definitely not a
> problem if we take this slow.

I hope we can de-escalate now and try to move forward while assuming 
positive intend and maybe slapping in a bunch of :) to highlight jokes ;)

-- 
Cheers

David

