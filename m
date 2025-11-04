Return-Path: <linux-kernel+bounces-884744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F78C30F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40ED21892C47
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618FA2E6CAC;
	Tue,  4 Nov 2025 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9Fi45Ya"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE50A29A9FE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762259036; cv=none; b=mZO/RjwGpEVCAryeq0A9P3Qw4Cxf2pqT1b4OoGJ5qWyf015QOURKHwNRHe1lNIpqmwpGcy4fF9XYBysQsQWWSv9FC5cHJm9r1P6WmcotVG9SP41/M9M3LUu02T+JDENNYyipWHKscVuQgMDyvv4zgUAe+/OfnRoHDhSYMFqJ0i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762259036; c=relaxed/simple;
	bh=OaulnFfIv9hYj/nauRuDYbAuQXPylBEP9GcGHpiUvAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxgRtamgRZKJcddAfGWydOgxJmBeg9pVCKgShZCoQFmBXA0nbGaeb5hdaROEStlQCpe2v4Z66hd/zwk/B2ewufLL2/TyKfJmSPnbblbuEtZXQBQ8mlLG5N4U5NNf+LWhp78ts7c5sZESE93gLgWTERRkz5EgEGgFgtgE2X1pdu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9Fi45Ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9585C4CEF7;
	Tue,  4 Nov 2025 12:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762259036;
	bh=OaulnFfIv9hYj/nauRuDYbAuQXPylBEP9GcGHpiUvAk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K9Fi45YagBaVytfPhJw99wYzHfVNhv98n74R+fFiWU8QxYsDvSsWBlIN6UqHzHzDM
	 EgagJn9KmmEi3ffbOXmcBMdPe+pwuq0fNlDsVtL3DxfEpg3PzU7uT6lUGHhQ4wbX+N
	 b2Ou5E1SOeTf7/myN14KvVyiJtH9HLgtOmmbUInr6fjXIq97H4IetxHdkF4I2tt5dN
	 3x/Uq3dQdVTZR+i6g01hAO0DkOSj6LnZuGrpJohlethDz4iBq2jV0w8SR+mlavFOPl
	 BhQTVhIVgdWIVRifdPNl83Upz+rjhgt6glK2tfydNYBic9UqNyuxaKKo4uhajRvBTq
	 uiQSXFDi0MWGA==
Message-ID: <52e064b1-819a-47b3-9f4e-7ab0890841e7@kernel.org>
Date: Tue, 4 Nov 2025 13:23:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] mm/userfaultfd: modulize memory types
To: Mike Rapoport <rppt@kernel.org>
Cc: Peter Xu <peterx@redhat.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
 <aQmplrpNjvCVjWb_@kernel.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <aQmplrpNjvCVjWb_@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.11.25 08:21, Mike Rapoport wrote:
> On Mon, Nov 03, 2025 at 10:27:05PM +0100, David Hildenbrand (Red Hat) wrote:
>>
>> And maybe that's the main problem here: Liam talks about general uffd
>> cleanups while you are focused on supporting guest_memfd minor mode "as
>> simple as possible" (as you write below).
> 
> Hijacking for the technical part for a moment ;-)

What?! That's crazy :P

> 
> It seems that "as simple as possible" can even avoid data members in struct
> vm_uffd_ops, e.g something along these lines:

Right, that's certainly even more "minimal".

In the end I agree with previous assessment that the original series is 
not completely a "modulize memory types".

If we want to make it easier for guest_memfd to support 
MFILL_ATOMIC_CONTINUE, then maybe we should focus on that, and only 
that, for the time being to make progress.

-- 
Cheers

David

