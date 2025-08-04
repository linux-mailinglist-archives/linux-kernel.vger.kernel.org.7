Return-Path: <linux-kernel+bounces-755218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2D8B1A32A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A3627A7CAA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E040266B6F;
	Mon,  4 Aug 2025 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIDoqjle"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D428217B418;
	Mon,  4 Aug 2025 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313908; cv=none; b=hBNaK2/DIlN4tGH8Hks005vbcSA0YPDwMxaZO/l+JVdsnVh4UIPWntGxyPRs8ytpQrsF4m6f8fN2SCJn2TN7BJuAq2UeuzP1b7/M4tTJRr4HawTTSrTiSe0TqrzXcY+PwrgR+ZlThTK740l0pMirB8zBZpqXyXE8Bm1w62W2QlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313908; c=relaxed/simple;
	bh=NTs4IL1Kwd8g0bmY4dYuUQcArWu0IxUvlGbhxSQ476E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFZOXJJ3PrhsKeRat4DUyjruMi4DYDzZb5h/EEDDV2Rj/vhFnNKbiGZZoEUNo8rOR9vxW/H9R2CjX4/+ZATQXK5PLocwSBedKicRFLinD5J5fHGClNtTlE7Md/tGYPPn3JNNu9qIS0jjQ3HOb7vBf69zSxW6XyM3N+AvAXKkjN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIDoqjle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30718C4CEE7;
	Mon,  4 Aug 2025 13:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754313908;
	bh=NTs4IL1Kwd8g0bmY4dYuUQcArWu0IxUvlGbhxSQ476E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIDoqjleeck4npbrxv3OkmfBzGnFEjjIdKjHNcZb58LOnO/ITcpfW7JabRH8VSXmk
	 6O5ESCqUuHsvRDdAzsyfaWjuEYEwvRpBKCvuVKz66CbPRny/vz3UV9E6fKEtVBagEt
	 EXDK/p1KbfN9kCRCsArU4NhVfL8AykP8dShRfCzihfvVfcFDKrEcxDX93tMmqaPFVD
	 BvKqYmZ9/t6sZn84vLsvP9D3ZZY7SAgyfKagsMYj38xMZLcgLuWZFlF9xF8KwXYLRq
	 0ukcZNdxqRFMBgSD53CFS1BRNWmPNlkXpBQiJNdefQYdNsYlUNKLVMR3SbUS9k7w4Y
	 GpfbrLlb26mNQ==
Date: Mon, 4 Aug 2025 09:25:06 -0400
From: Sasha Levin <sashal@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, corbet@lwn.net,
	linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <aJC0ssMzX0KWnTkG@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <75d86e96-cb18-4996-998c-da7ac0e97468@suse.cz>
 <9afd157a-296d-4f4d-9d65-07b89ab3906f@redhat.com>
 <2025072832-enrich-pampers-54b9@gregkh>
 <1bd04ce1-87c0-4e23-b155-84f7235f6072@redhat.com>
 <aId1oZn_KFaa0R_Q@lappy>
 <aJB8CdXqCEuitnQj@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJB8CdXqCEuitnQj@tiehlicka>

On Mon, Aug 04, 2025 at 11:23:21AM +0200, Michal Hocko wrote:
>On Mon 28-07-25 09:05:37, Sasha Levin wrote:
>> On Mon, Jul 28, 2025 at 12:47:55PM +0200, David Hildenbrand wrote:
>> > We cannot keep complaining about maintainer overload and, at the same
>> > time, encourage people to bombard us with even more of that stuff.
>> >
>> > Clearly flagging stuff as AI-generated can maybe help. But really, what
>> > we need is a proper AI policy. I think QEMU did a good job (again, maybe
>> > too strict, not sure).
>>
>> So I've sent this series because I thought it's a parallel effort to the
>> effort of creating an "AI Policy".
>>
>> Right now we already (implicitly) have a policy as far as these
>> contributions go, based on
>> https://www.linuxfoundation.org/legal/generative-ai and the lack of
>> other guidelines in our codebase, we effectively welcome AI generated
>> contributions without any other requirements beyond the ones that affect
>> a regular human.
>>
>> This series of patches attempts to clarify that point to AI: it has to
>> follow the same requirements and rules that humans do.
>
>The above guidance is quite vague. How me as a maintainer should know
>that whatever AI tool has been used is meeting those two conditions

In exactly the same way you know that a human contributor didn't copy
code with an incompatible license.

Quoting from Documentation/process/5.Posting.rst :

	 - Signed-off-by: this is a developer's certification that he or
	   she has the right to submit the patch for inclusion into the
	   kernel.  It is an agreement to the Developer's Certificate of
	   Origin, the full text of which can be found in
	   :ref:`Documentation/process/submitting-patches.rst
	   <submittingpatches>` Code without a proper signoff cannot be
	   merged into the mainline.

The Signed-off-by tag doesn't mean that a commit was reviewed, it
doesn't mean that someone tested it, nor does it indicate that the
person who signed off belives it is correct.

It only means that the person has legally certified to you what is
stated in the DCO.

>: 1. Contributors should ensure that the terms and conditions of the
>: generative AI tool do not place any contractual restrictions on how the
>: tool’s output can be used that are inconsistent with the project’s open
>: source software license, the project’s intellectual property policies,
>: or the Open Source Definition.
>:
>: 2. If any pre-existing copyrighted materials (including pre-existing
>: open source code) authored or owned by third parties are included in the
>: AI tool’s output, prior to contributing such output to the project, the
>: Contributor should confirm that they have have permission from the third
>: party owners–such as the form of an open source license or public domain
>: declaration that complies with the project’s licensing policies–to use
>: and modify such pre-existing materials and contribute them to the
>: project. Additionally, the contributor should provide notice and
>: attribution of such third party rights, along with information about the
>: applicable license terms, with their contribution.
>
>Is that my responsibility?

As far as making sure that all patches you take come with a
Signed-off-by tag, yes, it's your responsibility to make sure that such
tag exists.

Otherwise, this series doesn't add any new requirements on you as a
maintainer.

-- 
Thanks,
Sasha

