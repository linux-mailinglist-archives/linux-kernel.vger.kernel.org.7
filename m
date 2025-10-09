Return-Path: <linux-kernel+bounces-846519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E11E5BC83A6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6C784F7CC4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2852D5A07;
	Thu,  9 Oct 2025 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW4/S7E3"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D705523536C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760001182; cv=none; b=YRsGgC4kgOXCkB/jNLE5b/AAzrLvpvEPDfFsft4jf4QcsiUTMlGn4fPdVd+MhDacwlmr7uE4boznzm8naCMzavylG73gV57th+24Qr7ALO4xS9go80UIvjVB3m7fLo7nWsXjP1EVQ0OtE3fwNU7j9/42m2KKsO2sNf7GOmABbSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760001182; c=relaxed/simple;
	bh=7ov7X+H76YZ2kZPkU1rlQnIlT1HTKwdYcsZHXhrLcLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpG97aONusI2xg9Z6dapC1V+mMEv/CaVwIHqFBFacOxbjmF0Wi4nHBZx5hyxSxvnKzZLksfHXcHqrESk664sWO9dG4GmL4UTwCg/t6zk8aEbUweuSyJGWHhM/y5eQPJeG3qoJd+muItpEVZtUgcqsoAD0oPRw4V4MX7a8ChHff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW4/S7E3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27ee41e0798so12112785ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760001179; x=1760605979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=noGJIDsEGpbT4mVPtLItOHBIizt5I7YMxK5vpTBOvYc=;
        b=nW4/S7E3mJPgJ6jQdfxNFdKrAE20n0t2gB7AcVgIox9uLACU6iJgIHPZO+oPqwtKXE
         s1SHyT8RJPJ6IqzyjYpr/aS1Y7/6wP9n9ZofH9QunBe8uVE7De/4g6pEc+jG3IYNNKBx
         LlyFJ3EpJoUMYtr6SFRcbuisd1psr3+7y4lhCYh/IRELHsfyEQ7tn/GH8HzolaKSBjpX
         wxyumOy/PhI4FwjHTsNBJV/kjPcFwMloZhZjpySdwyr3cJn4j9HMO+2ftCnvuJd3mRKU
         P+JB08ekaTf08VpgDviak6LkMEQ5rsuOC6KcnEJ+hb7IbWu3HzPOlwo7IkYAGGz1WB+e
         LzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760001179; x=1760605979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noGJIDsEGpbT4mVPtLItOHBIizt5I7YMxK5vpTBOvYc=;
        b=VimMGJ3yR5KTsN3DUW6K+wZDqmldx9SddWSOt60z3JHz9M2djwxU4qwm/xeQGmqWhN
         EFKB+TSKE8sG1GL7aA8IoL6aYp9QsAwkPjJmG6Ydsaa/oCHT29QJCnY4oJDvPKmQdVJS
         HaOE3BsfbxCBkOcYugsemlNd9SQdzTmI26ttrklcv0InpggCFmsWQYWdhEnKw37DqTM1
         oZgUBHHv1Rc1TT0dRqg6pVHYrXkhTXTxe2mlqDgVHAQIB2COpyPr1u16NPN3Y0AdqiqL
         h6x0zD5gaY2xUhCL7RB7bl9eG8UgtSrXRj60Gp3MN19Oy6n6Rmd9VWM/jE2mjh3PqbDb
         Ovnw==
X-Forwarded-Encrypted: i=1; AJvYcCUlfYmhf0pILiDrOTY2IH5ro47edOErEhBoiaz/D1RwkD7bDGAUcRxDChgj6wpa/YeQWePybZ5zWkUBSDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9PWDD0r4W7wp4Rcoaub1Xgvy/2gdGIjuDAriCYW2UF0AHKZhh
	uCyG+3zAK/7+9oEbEqDa13P5w5r0gNB2ZP1EWz6Unon653N9kYaUGQBS
X-Gm-Gg: ASbGncvUr0XqtR6YM1AczDzyo5kKXScOqjKlV6vosem3Tnn6JOS4w58AnkkSy6COAiP
	NNfWO99LOB1tlBLp9l8Pa83ijeuhFbkfc29x7w0E+o2fPx1gMStsJ6evyWdYZx4dFHMHpqn60IW
	Xos6xo+3ZCBZVNpiLSatI+d0zMetVT83LLJXK6ma/yLUmwxfjvELB8dpcWMpef/7l8IcH3gbQxj
	ltgToaTsBDp21bcfOwUjmJXW587T9o2hOBuJGNvH2IG8kEOw/nMREHhoR+BZqoVe2WeMqjWXsIT
	mXDHk+0hxf/9dlaZcgoH1/c9Iix78by8gLAWtnDJo4bN8xbO23QoUFuxv918TwWwGA8UbVEzfr6
	9QvFZE0Ciz2aPVurMyPV3PSInA3rFC2Meh14v7orK5DG/lru3QKIZIuKoZ7beSw==
X-Google-Smtp-Source: AGHT+IGgc722wX6cnZ4WMCp7pNtwV85yDs1WMyb3Ue3/XLDo0+KBsbutwCUcBiVTue/uMgVkYBWZbg==
X-Received: by 2002:a17:903:8cc:b0:267:9c2f:4655 with SMTP id d9443c01a7336-290273ffcf6mr78713905ad.41.1760001179036;
        Thu, 09 Oct 2025 02:12:59 -0700 (PDT)
Received: from localhost ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f3de4asm22026565ad.92.2025.10.09.02.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 02:12:58 -0700 (PDT)
Date: Thu, 9 Oct 2025 17:12:50 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>, Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>, Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org, llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com, "David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 23/23] MAINTAINERS: add entry for KStackWatch
Message-ID: <aOd8kvWYIROq99vx@mdev>
References: <20250930024402.1043776-1-wangjinchao600@gmail.com>
 <20250930024402.1043776-24-wangjinchao600@gmail.com>
 <3913273d-12e2-426f-aec7-263b7f49008a@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3913273d-12e2-426f-aec7-263b7f49008a@infradead.org>

On Fri, Oct 03, 2025 at 01:50:43PM -0700, Randy Dunlap wrote:
> Hi,
> 
> On 9/29/25 7:43 PM, Jinchao Wang wrote:
> > Add a maintainer entry for Kernel Stack Watch.
> > 
> > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> > ---
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 520fb4e379a3..3d4811ff3631 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13362,6 +13362,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
> >  F:	Documentation/dev-tools/kselftest*
> >  F:	tools/testing/selftests/
> >  
> > +KERNEL STACK WATCH
> > +M:	Jinchao Wang <wangjinchao600@gmail.com>
> > +S:	Maintained
> > +F:	Documentation/dev-tools/kstackwatch.rst
> > +F:	include/linux/kstackwatch_types.h
> > +F:	mm/kstackwatch/
> > +F:	tools/kstackwatch/
> > +
> 
> Add entries in alphabetical order, please.
> 
> >  KERNEL SMB3 SERVER (KSMBD)
> >  M:	Namjae Jeon <linkinjeon@kernel.org>
> >  M:	Namjae Jeon <linkinjeon@samba.org>
> 
Thanks, will be fixed in next version.
> -- 
> ~Randy
> 

-- 
Jinchao

