Return-Path: <linux-kernel+bounces-864514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9303FBFAF16
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 784224F772E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5F630E0E4;
	Wed, 22 Oct 2025 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ6wIJa2"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B2230DD0F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122473; cv=none; b=jnhg1oHAbrrrdZAG5BZCh7Zv6NM8De1TIDjKefqzJUqyzZ2oiJpugrb1uXQ2lfoybDI8HSf6CK3wW1XsyntUJ1hilimzBiIwB/D0Xx8uaOidPa9F4Bomptz7020DTCYzf7G/0TY2v2PJ6kxhX4fYNlircAq1yMRMio8CTfi3sK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122473; c=relaxed/simple;
	bh=9b608PfnJC9fbFc/dPPvz0Pz7f/esnPjPKxlpzcvV/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4344T1LIyWxEu0+C1CRXcdrC6CQJDCJhYzw4zfCSBDEqddHHoLzjntfhsJ3uuF0JeUxehDTrVfZqMG3kzkeEKzM4igjwpQQUwDrwbIV3ZzbvIywiisXUBG2Rqp7zfEr0pGZz8r3B+9vv9Sj16JUTErNy2yEDPaKXce/d93zz4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJ6wIJa2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-471b80b994bso48427515e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761122467; x=1761727267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqzoRY4rsjrmxaOKCFdJygVQSVTQjgHH0ECphxa9ePI=;
        b=lJ6wIJa2+y3tyDR0TX/RYaLigszmhVXlhNK3p7ps/RusKgm6bDjfIZS2OzinAGWDeZ
         fecQcN+OSboAxbU8T3Kx/vgMPmUlvLjxC5T34rXJ9xNpIssHRVBIxK2IQGSKxKDhjAVO
         HfmOvW8lDO6O7B/68TepQ+Yh/tnlqcX7X53D1WRkZN/IDTTMrOPskRr9DGdycKoKqtq2
         Ielhs1rHbAxaTexVp63/VJ4etO6CmYX8yGuXO/lQWIrA7gQHDWLGXgSqgdULdXPv7pk4
         mhCneGZJAVN3s64FNsfLrF0eX4qNQHr6+H4Kitq1PDr+5xCwMqkv5DIDW1ipzZuIYCu4
         ItGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761122467; x=1761727267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqzoRY4rsjrmxaOKCFdJygVQSVTQjgHH0ECphxa9ePI=;
        b=QOk75sZGtrcIXunSJ1OGCpu6MQ6ahdz1fDapVj048qYLErPl5MtvMkXGBJCZC1zmn8
         HaRHl2+hiAhJACWz762h9IBBRaIz3zT+v6ntKkt6EI+lRFiVik5zVgfp/efTQr9kSNzP
         b2WF5M8OWbHv533WxmWxR+phe3YbJccO15QYehyG8a58CEmv4GCkmWStrX2i61bf54WX
         p3KlNBUekC04I/bqnbTMsRwjGIvJfoMLeCn4tAkxAqJAtS5gHUmbUkeAapEPs1Homr7l
         +jX7SwQl0fBO3GVIcc3D7Wra5GvpPWM8m7DdXPjEIesQA9/n1LSsNkllh7ZO25eubtgK
         647g==
X-Forwarded-Encrypted: i=1; AJvYcCVbtgZvcjlog+gFwLziSLq7Laixd86Ip3ipNGam6DgovKEUfb9y80fkG7zEDQNukRi5rO+j9e9vkcR5c4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ/rhxg2xSQRcFSqoqdwQZIyv2JwSKMMZmAEHT0wEtp3FHfPnH
	hlbj0GzEpn4lx1t9tD1DJCCbenzmmzIu76+mo3fPxyyJ1wFd50Ht3o8d
X-Gm-Gg: ASbGncsWnGar7R2QPy5WO7xHDIoNLW8AahkiRPd/mRbcOuooNS6VYx8yoUrxRecIQ9A
	PmecnNwQylNDxvLdNvSypVfoRrdMHpT/akKg5C2uOYGFR6DG0gD/Lcl4UeYeEA0nr8q2+lh5Wcz
	uwJhwm2gH+EJa5tLPwEptFP2Zbv0lSip1dq0inO+JtsaJ/0qjidumsRgV+INfT+omYTmjkcxhJq
	y5XMoruSR4ZvkOlcXSx0oa81z810jxF4b1emi8ijNP8Orhe4JV+PxWKX/VNODRcPm1IbDspLPUo
	21vAXO2lQk7Lh8cI1UgXZ2x2/aoFdLddGVyxrcIRwHjmBkh4mBqqE6BTsn0zjPXXLwQ4NXvJ3We
	OYMb+YECVxs+c0p63tvmy8ujfC0fPIimgRAnuSGIKwqeR2AftaqqpwXKFEqYY7IyL/p7QwWdtyQ
	3fbiwCmM7X6arbOT7JGoHq5OaWQNDJG9GzTbz7DrbApVl1rf60Sd3P
X-Google-Smtp-Source: AGHT+IEIef3ZfpJcj3fZLXc2Rj9C5/zpRhogHi1FW2SiAKDDthJK17PKYasG5M6YXrDDsQuh/E0Z5Q==
X-Received: by 2002:a05:600c:5029:b0:46f:b32e:4af3 with SMTP id 5b1f17b1804b1-471178784efmr122494905e9.1.1761122467205;
        Wed, 22 Oct 2025 01:41:07 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b985esm24865803f8f.34.2025.10.22.01.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:41:06 -0700 (PDT)
Date: Wed, 22 Oct 2025 09:41:05 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Alexander Graf <graf@amazon.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 31/56] x86/alternative: Prepend nops with retpolines
Message-ID: <20251022094105.7ea30194@pumpkin>
In-Reply-To: <DS0PR12MB92738D3C38021EE0B693326994E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
	<20251013143444.3999-32-david.kaplan@amd.com>
	<20251016110717.GE3289052@noisy.programming.kicks-ass.net>
	<20251016112327.GQ1386988@noisy.programming.kicks-ass.net>
	<DS0PR12MB92738D3C38021EE0B693326994E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 13:27:53 +0000
"Kaplan, David" <David.Kaplan@amd.com> wrote:

> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> > -----Original Message-----
> > From: Peter Zijlstra <peterz@infradead.org>
> > Sent: Thursday, October 16, 2025 6:23 AM
> > To: Kaplan, David <David.Kaplan@amd.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>; Josh
> > Poimboeuf <jpoimboe@kernel.org>; Pawan Gupta
> > <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar <mingo@redhat.com>; Dave
> > Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
> > <hpa@zytor.com>; Alexander Graf <graf@amazon.com>; Boris Ostrovsky
> > <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [RFC PATCH 31/56] x86/alternative: Prepend nops with retpolines
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On Thu, Oct 16, 2025 at 01:07:17PM +0200, Peter Zijlstra wrote:  
> > > On Mon, Oct 13, 2025 at 09:34:19AM -0500, David Kaplan wrote:  
> > > > When patching retpolines, nops may be required for padding such as when
> > > > turning a 5-byte direct call into a 2-byte indirect call.  Previously,
> > > > these were appended at the end so the code becomes "call *reg;nop;nop;nop"
> > > > for example.  This was fine because it's always going from a larger
> > > > instruction to a smaller one.
> > > >
> > > > But this is a problem if the sequence is transformed from a 2-byte indirect
> > > > to the 5-byte direct call version at runtime because when the called
> > > > function returns, it will be in the middle of the 5-byte call instruction.
> > > >
> > > > To fix this, prepend the nops instead of appending them.  Consequently, the
> > > > return site of the called function is always the same.
> > > >  
> > >
> > > So this results in:
> > >
> > > NOP3; call *%r11
> > >
> > > And you're saying a task can be on the other side of that call and then
> > > return lines up. But what if the task is preempted right after that
> > > NOP3?
> > >
> > > Same for all the alternative patching; what ensures no task is currently
> > > having a register state that is in the middle of things?  
> >
> > Ah, I found it, you freeze everything, which puts it at safe points.  
> 
> Yes.  In fact, I think you were the one who pointed me in that direction :)

Does that help?
It'll stop the cpu prefetch queue containing garbage and let you flush the I-cache,
but I don't see how it can stop the return address after the NOP3 being on the
stack from an earlier interrupt, or even the nmi entry itself.

I'm not sure, but if the kernel is pre-emptable could a sleeping thread have
a stack that includes the address after the NOP3 - eg if an interrupt at
that point is what caused the reschedule.

Clearly using multiple prefixes doesn't have this problem.

	David 


> 
> Despite the freezer though, this patch is necessary in particular because stop_machine_nmi() uses an indirect branch to run the handler.  Which means that while patching is going on, all cores are inside a function which is going to return to after the indirect call site.  And so that needs to be the end of the 5 (or 6) byte sequence.
> 
> --David Kaplan
> 


