Return-Path: <linux-kernel+bounces-755707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E13BB1AABC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 00:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80053BC721
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 22:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E07623ABAB;
	Mon,  4 Aug 2025 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJKfCdKI"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1117B4430;
	Mon,  4 Aug 2025 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754345014; cv=none; b=k4C6M3XOoetVN+eXJ0KtySPD8sd/5hdTrA0SdYDKgHloTpHxerojHdSFy5g+9JI1jmXyCJpJzWEmt4JxZl2hwPsQW9AQY2ya1yFzjXg8xsCOkFmy8otyNSJ3l6a1v2zLaKxOC5uMSv85SCZ+LQoeoE8V2hI70RPlHfjpCjirxvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754345014; c=relaxed/simple;
	bh=p2nBXXxlTFA2GEEJ3s1EKIPnbNXOdk9tfoQuodXc/HQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=b8IvXv3mryLkH1Gog5GnJPuHC2OrMw4b9M94ZYQhXJtezcluP+aHXMrJcokuQbK5nEjb2+M+0mjBz3Y32Q5KhQp2UmzMGA8OGM2OmFvvqtVqt8MP/X9LHB8RQpeS0TJgt9yWPThX0iZyVQ+9UafM5Bzn/NOLgcZGOG8yAZmYcTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJKfCdKI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6157b5d0cc2so4999910a12.1;
        Mon, 04 Aug 2025 15:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754345011; x=1754949811; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vV+l/AoIQmjTiJkoSmnJ7PZO37+auBZ0CAATYzrLrwo=;
        b=UJKfCdKIVFPUeCwSVe/uYgYBGrQD0PScj+yFM2FmhOoY57881+0nbLl/SKZFML2pN6
         murPMOBoLkZqvmN5FRRfff1TspW9ZK4RPfD2gVHt/+u4LrR0RBgqR+xlyFUAOnj7ulF6
         3leb5vyDb7MeTEipJVHqHwlSZ0bgfV8uIDEwL60RRNr3GGWna0vaXqx8t4JP3cI+mJEI
         wRikSAM90fKABDvgxUtam/6ACICTgDq/2GhBVkpHsIJqDbV8V+tAZbVtIGLkv/UjuusK
         kU0LB6A2Ess4VJAew6wy6I57whvH0Aoi/SXGne0d1bO+EzcPKECrdIc8GB/PKWD0dWaG
         ob2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754345011; x=1754949811;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vV+l/AoIQmjTiJkoSmnJ7PZO37+auBZ0CAATYzrLrwo=;
        b=oR1COCsqkxEpWrYSulbCB8Erb+leWh7LypHSV2gfaexijfwDSL6tfnquvx6k6d2Fw5
         FiWkrnZkDz2gCph83C/j+LDIgTMIs7kpkPm7bDU3seTBgYSmYBEP3TzvsGikjr0sbbiZ
         sHwRFGf9y1msTJ1LnfLmqZo9XClWPgcWum37R2Px2tKafJoxYoh8RCYR0e8XSB7OXUbH
         k/O2UnDjgQUNERrwk/A+g0OgshkIh6uWl7GztM8WVze/dwSICl4eE475upYcD7YGCEcA
         DmDmw46aECljscf64q58vuj3UJXh56s8WEjcSwijx9iRzNNi+/1l+dqScrxA0Y/0ahHY
         DtfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcn6QJGSrPC+70a8XT/0fh7vV1QiMsuYwkDAkPIgNKf9ubbisgxJUO+gbCM/OVsg1HxxoMwsv1CGEf@vger.kernel.org, AJvYcCV86pIgRX2wf5lpNdvc3AthQTHr7dQdcY2Pl+de0fKLAxatkWxBYtZtH9ApskwG+cWocn7w4179Vck=@vger.kernel.org, AJvYcCXVSvDb15SISCgEGRvlM2oViQMKIr+Zr54vN39vyVZS5i0J4MvICYURftkJaLbVgZIzXeSjPxnu6UF51PbH@vger.kernel.org
X-Gm-Message-State: AOJu0YxZv3WI8LvflgG8SMlpkxi6crCgLJ4AKA4WVifu+gk344j+9YhY
	ECqdGsaOr3ssuBMVte6C/DX/zM5ui8BrFsHrNPsxKN21RuNlF1Z4mUzP
X-Gm-Gg: ASbGncsf5rebdzHEpPsT0a0SQzi0MYEndwMbcRxYxKtxvlCE0VAhrNHiW7euMzElHuS
	0Lbkr05SDpd6M4kRq3GL2h7tUa+3plqX6XWxjMTHzVirI1nWihgnuTl+FhlpsRIJS/etTTgfDoK
	mTagXqzNnYNcgge61TabQwh4UXF+9AD5zOEiAUP//jW5thbo9LW2q/uQ2tx27hWHxz9FyqjQciD
	5Wo6IIqSnJDEA55n/7U8+SSct8pfq9tx/D/1HkLH1Y3GaLv6qWWZlfmOBsv29ow82IozLcMDJu9
	b+4gPD41mJtL0ONdOGhdy/UXFFPOPgr05e0rKfAYdc8uJW86Re4tMp/J9yfZGutvGvzEgvb8oN/
	0eI/aog==
X-Google-Smtp-Source: AGHT+IFNnPbgloatd/bauAsrBdwIztzDNxa/G9LyVYPHGTRJkfeh0ibtHkV1YCGfc/jdUx5xC6oJJQ==
X-Received: by 2002:a05:6402:51cb:b0:612:dd26:9fab with SMTP id 4fb4d7f45d1cf-615e6ebc44fmr9414129a12.7.1754345011002;
        Mon, 04 Aug 2025 15:03:31 -0700 (PDT)
Received: from localhost (twin.jikos.cz. [91.219.245.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a9113e40sm7368688a12.57.2025.08.04.15.03.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Aug 2025 15:03:30 -0700 (PDT)
From: Jiri Kosina <kosina@gmail.com>
X-Google-Original-From: Jiri Kosina <jikos@kernel.org>
Date: Tue, 5 Aug 2025 00:03:29 +0200 (CEST)
To: Sasha Levin <sashal@kernel.org>
cc: Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, 
    Greg KH <gregkh@linuxfoundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
    corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org, 
    josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org, 
    linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
In-Reply-To: <aJC0ssMzX0KWnTkG@lappy>
Message-ID: <alpine.LRH.2.00.2508050000580.22517@gjva.wvxbf.pm>
References: <20250727195802.2222764-1-sashal@kernel.org> <75d86e96-cb18-4996-998c-da7ac0e97468@suse.cz> <9afd157a-296d-4f4d-9d65-07b89ab3906f@redhat.com> <2025072832-enrich-pampers-54b9@gregkh> <1bd04ce1-87c0-4e23-b155-84f7235f6072@redhat.com> <aId1oZn_KFaa0R_Q@lappy>
 <aJB8CdXqCEuitnQj@tiehlicka> <aJC0ssMzX0KWnTkG@lappy>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 4 Aug 2025, Sasha Levin wrote:

> > The above guidance is quite vague. How me as a maintainer should know
> > that whatever AI tool has been used is meeting those two conditions
> 
> In exactly the same way you know that a human contributor didn't copy
> code with an incompatible license.
> 
> Quoting from Documentation/process/5.Posting.rst :
> 
> 	 - Signed-off-by: this is a developer's certification that he or
> 	   she has the right to submit the patch for inclusion into the
> 	   kernel.  It is an agreement to the Developer's Certificate of
> 	   Origin, the full text of which can be found in
> 	   :ref:`Documentation/process/submitting-patches.rst
> 	   <submittingpatches>` Code without a proper signoff cannot be
> 	   merged into the mainline.
> 
> The Signed-off-by tag doesn't mean that a commit was reviewed, it
> doesn't mean that someone tested it, nor does it indicate that the
> person who signed off belives it is correct.
> 
> It only means that the person has legally certified to you what is
> stated in the DCO.

Al made a very important point somewhere earlier in this thread.

The most important (from the code quality POV) thing is -- is there a 
person that understands the patch enough to be able to answer questions 
(coming from some other human -- most likely reviewer/maintainer)?

That's not something that'd be reflected in DCO, but it's very important 
fact for the maintainer's decision process.

-- 
Jiri Kosina
SUSE Labs

