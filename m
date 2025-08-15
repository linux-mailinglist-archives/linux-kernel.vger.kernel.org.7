Return-Path: <linux-kernel+bounces-771023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E2FB281D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5FE1B62339
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7646123A9B1;
	Fri, 15 Aug 2025 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="1Cm0G0fy"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98211224AE8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268163; cv=none; b=ag3YX+kj3KxTMADMJBOCQZZ8OoGcLyZiYWN4TpvEFzs/fqFWemY2bbYGuPz7ra8fxd3EfUK1Gxlwmvoumk5E2MKrTTrOlMJLYf4WNUTHPXLH97/fo56FNL3UvsU9Xdm+LfiZl7jzi46+D2xZcDZnncCwBDmU36kN0GMtnrNQwCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268163; c=relaxed/simple;
	bh=RVW9cSXcUu1m5JGd+bvJ90FNpKko1SHEvvh/ezxt6qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZfAX1Grpl36QSqI7j0x0+wIRwCLdIwknoX5pgGQ8OlUQake9ZNoNgCv73PBl5QrV1oNTfIA+Jt7JW2Vd6pGlzdhzh+JOwHRlrdHs7+gn1sN3hwPJyaYfAZTTh2TTqQlq/8V6JksRC6/Ul4iL91wNpapGX6K4m4yYq/3ZF2O55I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=1Cm0G0fy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9edf0e4efso1210641f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755268160; x=1755872960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dEwM/gpinhi2XOkvEAyf9mQGVVoziKKdbRHc3b2tU2Q=;
        b=1Cm0G0fyjqv1m8hdOeKClNqWkFEuBbfhoh8S3VhGSKijpmmcxUWKEQjEvWxiXEfkwY
         U4iV8YP1oYyQMeixgI1y6ENkDkGmlCdlTNBlj14KhUklqfElpxLXgHZ+luuFzUtlulWn
         ErfG0fMjRf6unQ2zFsBaoAk8lL/WQEfhziqBEE2/rUKgyByKWHRwA66KmdFgprROGn7Z
         BvRiJ8ZNvnlrvezIrcfPyEa5PX2+S+MvDus56W5zCMeUDgTWonmY/Hta445yCSPuxVka
         MOi7z7oj5JXAj594j/qHaY7O6OYuTkUFRolQ4b3HflyazKQZsBckBH+4cOXs80J92mop
         1z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268160; x=1755872960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEwM/gpinhi2XOkvEAyf9mQGVVoziKKdbRHc3b2tU2Q=;
        b=MMVid5NwjKs5Kuo83gJE7axGCKcA+PHzWZAS87Y+n7xxqcCUUbGR1tMz+pMlYOXE9x
         PxUcrMcPWLnTa3mTMSWrxIDZVxhFtFVf73XvaduQGBqzSH0UooPZmtCdjfN7I+syGGBt
         WL/SOJ/fesxL4PN7uS+m2AfzLtxO4Q6MIfrgqPxEhO+no3PUv/u+cfnKUToePVTiXSVD
         P77PUxYKTMTNjjJPu5mbFBL0yibs/PXIXz+0y7snB5SIy5e8ylvoRNyfWlrSnf2xY+Xq
         cSjko6bKDp7KyPRiPqEq0BgDVu3OaXYMFFmnSfwJk6LnDz02wOAqxk9K00akezyi8P18
         AizA==
X-Forwarded-Encrypted: i=1; AJvYcCXTZL6mOtmS+7nDz+sahhdR9hJt5/QydQk1Yl6XyJdqH1fGORfkmQM/Secbt3VH6hacU1CKLtBImHnQz+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWTIDEV/fKKc6qJIoxYZMllx1ax/h0Bm+vfkkv+Y0Aq+9VcTXp
	ivBEIO3T3HnIjiLqkhYO1n/nKTseWnTVGeIda9GdqyPIQdKGoj3pOjd/a86UPoyqojM=
X-Gm-Gg: ASbGncsdfEPq9Kp/CH2keAMMDzrxxl58Ym/0aac3/OjLHHS0ly0mwxa6FfQv+wKYLQe
	tP3lJyv2opFLiObovhfwTYmn3CJCcQySinOCRXJTx00WzQOR60d62Fdlf4ZYDetZz9tyk6MSHz7
	jkFWTBM55Qp8wrEADRYIkRhGlDBNdfsk468Azh6ODHWqVLneSQDtZVr2ofJfFXqgzuXFaLWky7H
	4oTAyuSWx3bsFOJjNfDQJ7taaKgHWR8AWMQ6p+XDbSRegDN2caBfu9E6jvKQMFJ2s6w2QgUijvw
	C3gC0tpFIhGMED4juooZ5BzdVf8OgSP7DrEYNRAMQcBjkiVf1h5L/htqZ3r7wXs1jQPQhNqEE9B
	bd3t4GBOBhD8txxbEAvWTnXaUr1pWhvuIgaikYRJdMYSdFRSzAj7xQfii/PVmFeIy3zyPg8HHRf
	FApWCy3g==
X-Google-Smtp-Source: AGHT+IGcsKXPoXqKCWjr+xBECNzFfr6DUpTtNHm2OUxibNs/VdcsyL+kzq6Oc8b1vYPRnE6BSoDntg==
X-Received: by 2002:a05:6000:40e1:b0:3a4:d9fa:f1ed with SMTP id ffacd0b85a97d-3bb66d1f4e1mr1923586f8f.13.1755268159688;
        Fri, 15 Aug 2025 07:29:19 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64c30c38sm2113365f8f.15.2025.08.15.07.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:29:19 -0700 (PDT)
Date: Fri, 15 Aug 2025 15:29:17 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Nir Lichtman <nir@lichtman.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-hardening@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kdb: Replace deprecated strcpy() with strscpy() and
 memcpy()
Message-ID: <aJ9EPQNk2bcOMP1h@aspen.lan>
References: <20250814220130.281187-2-thorsten.blum@linux.dev>
 <aJ72XZ0VkrCkKFNy@aspen.lan>
 <710CDE93-89CC-4B60-A582-5F9B2916ED72@linux.dev>
 <aJ8cyXzMaa9b7ppN@aspen.lan>
 <72F30E3D-2887-4494-B58C-2042AC880C1B@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72F30E3D-2887-4494-B58C-2042AC880C1B@linux.dev>

On Fri, Aug 15, 2025 at 03:16:27PM +0200, Thorsten Blum wrote:
> On 15. Aug 2025, at 13:40, Daniel Thompson wrote:
> > On Fri, Aug 15, 2025 at 01:28:01PM +0200, Thorsten Blum wrote:
> >> Hi Daniel,
> >>
> >>> On 15. Aug 2025, at 10:57, Daniel Thompson wrote:
> >>> Sorry but a strscpy() where the length of the destination buffer has
> >>> been calculated from the source string is way too much of a red flag
> >>> for me.
> >>>
> >>> Put another way if there are "no functional changes intended" then there
> >>> cannot possibly be any security benefit from replacing the "unsafe"
> >>> strcpy() with the "safe" strscpy(). Likewise abusing the destination
> >>> length argument to truncate a string makes the code shorter but *not*
> >>> clearer because it's too easy to misread.
> >>
> >> Deliberately truncating the source using strscpy() is a valid use case.
> >> strscpy() allows the size argument to be smaller than the destination
> >> buffer, so this is an intended use of the size argument, not an abuse.
> >
> > Sorry, I didn't phrase that especially well. I regard the abuse to be
> > deriving the length of the destination buffer exclusively from the
> > state of the source buffer.
> >
> > As mentioned, it would be much cleaner to eliminate the string copy entirely
> > than to translate it into something so similar to the original strcpy().
>
> Something like this?

It would feels disingenuous of me say "exactly like this" because I
think your code is nicer than mine would have been for this (I suspect
I would have been lazy and kdb_strdup()'ed str+1 and injected a
terminator)!

Looks great. Only one comment:

> char *kdb_strdup_dequote(const char *str, gfp_t type)
> {
> 	size_t len = strlen(str);
> 	char *s;
>
> 	if (str[0] == '"') {
> 		/* skip leading quote */
> 		len--;
> 		str++;
>
> 		if (len > 0 && str[len - 1] == '"')
> 			len--; /* skip trailing quote */

I like the extra diligence of checking the trailing quote but perhaps
combine the two if statements (so we only chomp the quotes if there
are two).


>        }
>
> 	len++; /* add space for NUL terminator */
>
> 	s = kmalloc(len, type);
> 	if (!s)
> 		return NULL;
> 	strscpy(s, str, len);
> 	return s;
> }
>
> This should probably be a separate patch, right?

I think so.

I generally figure if you have to put two paragraphs into the patch
description but each paragraph makes sense in isolation that's a sign
there should be two patches... and I think that would be the case here
(the paragraph explaining the memcpy() piece and the paragraph
explaining kdb_strdup_dequote() would make sense in isolation.


Daniel.

