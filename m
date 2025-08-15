Return-Path: <linux-kernel+bounces-770063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E233AB2765F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DDA568424
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA91292B58;
	Fri, 15 Aug 2025 02:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j4COaN5t"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B960291C2D;
	Fri, 15 Aug 2025 02:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755226393; cv=none; b=aFNeMzi30Owv53pt2aBzPleXOnxhizA0zoez8GsWgWKsFkqICr7XgsPLqLwI7Iot/nqBZgZE0IOJW9URjQU7OEPGnYcgGQ7s3RmBr2JaECu80OVW/vuJLM0au6Xlg3hO8719u2gcSDmIeDkAT8+jJ3mHdn6sKqRRHQDKyyoWQQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755226393; c=relaxed/simple;
	bh=wad71HYAYfLhhLqPojmKa25g/oEHTWLZegrpvBYkr7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WR0/JHmNZdH0GwQeRykqJAgfYMksAs0+KsRhBzeuN3zlFSszBR17qY8qPfAHRJ4uWizX1HeZHr5TK60pLp5gQxlJm5wjTSis7VJ//PT2lJ9LljCY4grRehbo069GDMzvDeJLrEsibCc2cC60jQZnPY3xk6EUDK0/qBCrjm0ig9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j4COaN5t; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=QZVCzrbuC3u5VaWwoobTCBcWvATTA38krFlGKxEqZJE=; b=j4COaN5tYuRhIY7ZY473lK72dY
	EiguNMWI8t/0QwYXS7gawwzmkBkizObitNkYcK7EME9QFTygLi60wo1won4CXE2iX2Vgu5s6t8BU4
	xLh0H8c1pttR7Itt4pwZHP0rQ+ocDKMAw4v9mHcI85L8Tz+8fjRj6cw1AQhxUJB2Oa4qaKmkNpep5
	J25N+vxYlLRiu9jCPQE1IBBwpWb3iMJA58AcPwsc0GyKkhSoESmArSEEliGF8kUhEX/pPR2Ptn0vA
	TKbGQPTlQB84/rJel8Xm3a+9VRblK+nyA9d6bEjS8v7GRB4UJZRst86YmSWgIuBRKHk/uslycBJ0b
	m1NBhPCw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umkZ5-00000001EKb-2h1k;
	Fri, 15 Aug 2025 02:53:11 +0000
Message-ID: <b63fb30a-5d33-42bd-bdf3-b8dfb960bdf5@infradead.org>
Date: Thu, 14 Aug 2025 19:53:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/13] Collect documention-related tools under
 tools/doc
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Akira Yokosawa <akiyks@gmail.com>
References: <20250813213218.198582-1-corbet@lwn.net>
 <e84e288af0536cdc406c787301bc6b9b11c0be0a@intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <e84e288af0536cdc406c787301bc6b9b11c0be0a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/14/25 7:59 AM, Jani Nikula wrote:
> On Wed, 13 Aug 2025, Jonathan Corbet <corbet@lwn.net> wrote:
>> Our documentation-related tools are spread out over various directories;
>> several are buried in the scripts/ dumping ground.  That makes them harder
>> to discover and harder to maintain.
>>
>> Recently, the idea of creating a dedicated directory for documentation tools
>> came up; I decided to see what it would look like.  This series creates a
>> new directory, tools/doc, and moves various utilities there, hopefully
>> fixing up all of the relevant references in the process.
>>
>> At the end, rather than move the old, Perl kernel-doc, I simply removed it.
> 
> A wholehearted
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> 
> on all of it.

and
Acked-by: Randy Dunlap <rdunlap@infradead.org>
for the series.

along with using either of tools/doc/ or tools/docs/.

>> The big elephant lurking in this small room is the home for Python modules;
>> I left them under scripts/lib, but that is an even less appropriate place
>> than it was before.  I would propose either tools/python or lib/python;
>> thoughts on that matter welcome.
> 
> lib/ contains code that's built into the kernel, I think lib/python
> would be out of place.

Would tools/docs/lib be OK?
I wouldn't tie it up to a specific language,
but I don't have a strong opinion either way.

> IMO tools/python (or tools/lib/python, no strong opinion) is more
> appropriate.

-- 
~Randy

