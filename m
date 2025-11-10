Return-Path: <linux-kernel+bounces-893654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C200FC48128
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E153BFAA1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A88F27B4E8;
	Mon, 10 Nov 2025 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQ8J346h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E006828003A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792515; cv=none; b=sBv3cGT+rGJibUGg84k6J6r8pxUr+6UTrVYyPe9CiXEQuUzXwO3S3sK/l0dU3fFG2iL1QqKWw6jRnHapIA8FAW77pL5zHUI17ouNDZ4mQkVB6s97JRMk1e7YZq78rlS+UHbrtP4v386osPVnuw3rc08lJzKffEbuleiJvKoN170=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792515; c=relaxed/simple;
	bh=iVOHbdLwyLHsPePA0hJoNc2+uXAZY5dcz1Lv+efKUAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVEtw+Tz0gGI3BnRN12hfr7mUONeK7Q2svqyMO96vFE8Pe+8tJq52UrmdetFjIYEWitNGfF9P1D9tDZefoykgSl8vTGvJRDGnTMSy2yL1p/SxRRudIUASciQBc6UXgQQ5JRBNCUKds58QczQDbi3fdZSQTXumZTsVzENa8+p+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQ8J346h; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762792514; x=1794328514;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iVOHbdLwyLHsPePA0hJoNc2+uXAZY5dcz1Lv+efKUAA=;
  b=eQ8J346hi27HFueovo3u75kVe52MDTAtFcHWXR8rAxIvlwZJKGfnNp7K
   fGtqDhLoeV7Gbts0rcHLgoA+Bcj2HlUnaFV/99AySqm/CntDroEYojA+C
   A6a/gCRn9s3NeOlMPE34l7UD/1A13wi6r2XRzOjVeK+EgM0Ev/camNHep
   tGRg2JdjoCWxwpCfn/G8xJTnife/tWGhwlwiqCZR4RVQ7ew3n+fAsLO1b
   94Ak53veZrhF7iFizX4g9u53w+138Zx2XuYlsjsPYGpvwkank1rkIhvfF
   IgEB3yi3HShpJSSyM7JMowS1d5rQMd1+VsQJI0mlvQ8O7glYYMmu7JqkW
   g==;
X-CSE-ConnectionGUID: AyMUgI1aRKmmVd8bb3OlHw==
X-CSE-MsgGUID: r4Azuw6vSGypmTTTF+6mHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64754446"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="64754446"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:35:13 -0800
X-CSE-ConnectionGUID: j82Ni7gxQ5qRe6b2XLyxDQ==
X-CSE-MsgGUID: 9GU5plxWRpmSAtA9ioS30A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="225973982"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.111.198]) ([10.125.111.198])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:35:13 -0800
Message-ID: <103ee61c-f958-440c-af73-1cf3600d10fd@intel.com>
Date: Mon, 10 Nov 2025 08:35:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for tool-generated
 content
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Dan Williams <dan.j.williams@intel.com>, Theodore Ts'o <tytso@mit.edu>,
 Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Kees Cook <kees@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Shuah Khan <shuah@kernel.org>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
 <11eaf7fa-27d0-4a57-abf0-5f24c918966c@lucifer.local>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <11eaf7fa-27d0-4a57-abf0-5f24c918966c@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/25 02:48, Lorenzo Stoakes wrote:
...
> It also seems slightly odd to produce this in advance of the maintainer's
> summit, as I felt there was some agreement that the topic should be discussed
> there?

The TAB discussions have been ongoing and this document was mostly put
together before the ksummit thread even launched off. This patch just
suffered from being put on the back burner.

> I think stating that we will NOT accept series that are generated without
> understanding would be very beneficial in all respects, rather than leaving
> it somehow implied.

I actually don't think that's a tooling-specific requirement.

If you're posting a series, you should understand it. I've seen quite a
few cases where folks will pick up someone else's work, forward port it,
and post it again without a clear understanding of the series.

"Understand and be able to defend what you contribute" is certainly a
good rule. It's also concise enough to have this document touch in it.

Would that suffice?

>> +Guidelines
>> +==========
>> +
>> +First, read the Developer's Certificate of Origin:
>> +Documentation/process/submitting-patches.rst . Its rules are simple
>> +and have been in place for a long time. They have covered many
>> +tool-generated contributions.
>> +
>> +Second, when making a contribution, be transparent about the origin of
>> +content in cover letters and changelogs. You can be more transparent
>> +by adding information like this:
>> +
>> + - What tools were used?
>> + - The input to the tools you used, like the coccinelle source script.
> 
> Not sure repeatedly using coccinelle as an example is helpful, as
> coccinelle is far less of an issue than LLM tooling, perhaps for the
> avoidance of doubt, expand this to include references to that?
> 
>> + - If code was largely generated from a single or short set of
>> +   prompts, include those prompts in the commit log. For longer
>> +   sessions, include a summary of the prompts and the nature of
>> +   resulting assistance.
> 
> Maybe worth saying send it in a cover letter if a series, but perhaps
> pedantic.

Do we have a good short term that means "commit logs or cover letter"?
"Changelogs" maybe? But, yeah, we don't want people reading this and
avoiding putting stuff in cover letters.

>> + - Which portions of the content were affected by that tool?
>> +
>> +As with all contributions, individual maintainers have discretion to
>> +choose how they handle the contribution. For example, they might:
>> +
>> + - Treat it just like any other contribution
>> + - Reject it outright
>> + - Review the contribution with extra scrutiny
>> + - Suggest a better prompt instead of suggesting specific code changes
>> + - Ask for some other special steps, like asking the contributor to
>> +   elaborate on how the tool or model was trained
>> + - Ask the submitter to explain in more detail about the contribution
>> +   so that the maintainer can feel comfortable that the submitter fully
>> +   understands how the code works.
> 
> OK I wrote something suggesting you add this and you already have :) that's
> great. Let me go delete that request :)
> 
> However I'm not sure the 'as with all contributions' is right though - as a
> maintainer in mm I don't actually feel that we can reject outright without
> having to give significant explanation as to why.
> 
> And I think that's often the case - people (rightly) dislike blanket NAKs
> and it's a terrible practice, which often (also rightly) gets pushback from
> co-maintainers or others in the community.
> 
> So I think perhaps it'd also be useful to very explicitly say that
> maintainers may say no summarily in instances where the review load would
> simply be too much to handle large clearly-AI-generated and
> clearly-unfiltered series.
> 
> Another point to raise perhaps is that - even in the cases where the
> submitter is carefully reviewing generated output - that submitters must be
> reasonable in terms of the volume they submit. This is perhaps hand wavey
> but mentioning it would be great not least for the ability for maintainers
> to point at the doc and reference it.

How about we expand this bullet a bit?

- Review the contribution with extra scrutiny

to

- Treat the contribution specially like reviewing with extra scrutiny,
  or at a lower priority than human-generated content.

That's a good match for the "Treat it just like any other contribution"
bullet. Maintainers can either treat it normally _or_ specially.

>> diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
>> index aa12f26601949..e1a8a31389f53 100644
>> --- a/Documentation/process/index.rst
>> +++ b/Documentation/process/index.rst
>> @@ -68,6 +68,7 @@ beyond).
>>     stable-kernel-rules
>>     management-style
>>     researcher-guidelines
>> +   generated-content
>>
>>  Dealing with bugs
>>  -----------------
> 
> I guess this is a WIP?

