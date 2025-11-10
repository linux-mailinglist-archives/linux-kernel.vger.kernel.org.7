Return-Path: <linux-kernel+bounces-893804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7491EC4867B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5E6188F2BC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DBE2DE71C;
	Mon, 10 Nov 2025 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F7M8HfQV"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008F62DC797
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796662; cv=none; b=jpFE/5LAiCMwzh/3hpN74u6Urb95txbjLH4j2/oRlozD5ozn/CT6Bf4PZpUPOZcSf7shg6n0ROhJf3il/G5bQyTBvrcprC3Qz4dhtMzNHgTUdSmFcK+iHepKgHIuRMsKig+ITT1eiJiFDixSOzo1ekNihOeC2Wp/Fd4B/TbaGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796662; c=relaxed/simple;
	bh=aJkXTAL7hko1vF8GGGqXUOq9IdfVkF6MkoKhNUkblxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCb9YCJ+0RMoE0JLgSOuijs1upMvWMstUa0ZVdEsJPNmZzEspAUOGJBlziqiCiyL6gVKPW77tIDGqr7RSWzWmiDdGTc8xhZNzaSroNNJ7xdk7SBe39aNankFOGDcndz+lt4lY5fBN2Mrc7BmvGV7Gdit9viLyJ10THdr6qArQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F7M8HfQV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b6d402422c2so668584166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762796659; x=1763401459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aCzk/qbLhCwNEv+1dx5n8o3k2LQtS9clijGkZLAmnGM=;
        b=F7M8HfQVhlv2KKNovJKtL4c8+0OwP0jdMvhmNmHpwdjoiUmwmWK2scDj0IGYItdHAL
         PwTjNno3sGBg0CHKQ7H9lUl+RUAxC/GeWDZ7pO/h0+REEb5Y88VSoHcRoLmItu2nmcOL
         EHbTjxI6GwSUgZr+G2N+vxXS+tiEpDiKPps9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762796659; x=1763401459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCzk/qbLhCwNEv+1dx5n8o3k2LQtS9clijGkZLAmnGM=;
        b=UGRu4by0zHtTKrvCYZO9gyiQYg6PuROtFJe1efMrf+CecJMgW4Qluc8EY4WJSI5GUx
         eZPn5CSMEwxWK3HDy1OzmMad8Pt7QKxirLI9/E16Jqwvb3T7Q6T+Vv5tBH9mJrTSRWuy
         CHnZ8Ka4ppcM2NxyoeTkB9hRbbgHR/PQsKQknr/As1tsR/GsLUDMXrv+XtQcJXxQo/1I
         A7S4kuTpnTnWHi4Ez8LjTZv95pwa0aJ6+pqHIHNJ78pKNrDjYjQLRzCvEgrSoInEMe0W
         1rUqCXTxe7I69qlpDITRnXCs8W5KuWL2c46bnRSZzoBNcgHjyV9aWNluouioAaclA0qt
         lsTA==
X-Forwarded-Encrypted: i=1; AJvYcCU5rkzTMtMe8p5CUdNolEIlqMgYQmiScRzVAzATzqzUy0fVLd/r31nY+QKZ7wfIS6fG6DgJ6fb2oPiTOCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWOy19Vvs3NrtDAy+Z2THty0s7y/0pfvAPdxwqg0aiHDR9xeOa
	KsKSVQDP17/PEYSFgf1UK97lZdfQPB2gUigGL1NIyCr4hcyvAZgklJsdObUV/MS1pQVol7LO9TA
	vw7Rdna0=
X-Gm-Gg: ASbGncsEMACXEP/b0OOCQiegtQhFkZt6e4kJqKGM8hcZwziKO//AZp90q5+0dDGeUBl
	4XDrGiYJfdHAysGy5TvWM+0XIM4XJXRzNNwssCD/iGo4DH5+lA0G90egT2MVfYFjcZd7B87VdG6
	HBkZEvwnKOhPOBg1/UaOr3zXjdGHkhK7EcuuxIdlGmFz1jNYgNhOPVgQzcfv/yXhGUZJ2VwzLMc
	ZEmrsPgKNeS02OmpwVFn0v15esAyWHWoxjJ1lPwTFnlIFBYu+jPqUie1dbXwo/KNekUBQvF4qAU
	ClG2T3A8mjhfNkOtxnZL7Nl+4gUYvoc2KV+mdhvV/rfx8Wv3R/hqWJgbSSm91aKL2CCnNb3AWLC
	yPekp/o7LUJo97FXHYSIw4pJylq0XK1v6YKiAGfKvtik0sRP8HfYL9ipXKnSCUXTCj9xrPr+imh
	sQ6FeKCwAAKODj661YOI0HMD4oS8XvcMk3eRtEj6pda8wOT0f7ww9tj4BsFu0N
X-Google-Smtp-Source: AGHT+IGNocC7ufgllAHxFmtPkKy6D6Y4iSmkTadiVAT0QHIDNjuOMs76fkDz0toztX3NRhF0DM8AaQ==
X-Received: by 2002:a17:907:d22:b0:b70:30c8:c35 with SMTP id a640c23a62f3a-b72e056004emr874767766b.62.1762796658930;
        Mon, 10 Nov 2025 09:44:18 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf312240sm1162097566b.18.2025.11.10.09.44.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 09:44:17 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so5012188a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:44:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRtpavL8Im3iGfbaNWAJGIRE22pc1zxR2hq+/Jsu/D0vG3rE8/cdfr9D9OrKCOohRvwfdTYH/UM8B2HHY=@vger.kernel.org
X-Received: by 2002:a17:907:3dab:b0:b71:ea7c:e4ff with SMTP id
 a640c23a62f3a-b72e028a45cmr778784666b.6.1762796656727; Mon, 10 Nov 2025
 09:44:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
 <653b4187-ec4f-4f5d-ae76-d37f46070cb4@suse.cz> <20251110-weiht-etablieren-39e7b63ef76d@brauner>
 <20251110172507.GA21641@pendragon.ideasonboard.com>
In-Reply-To: <20251110172507.GA21641@pendragon.ideasonboard.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Nov 2025 09:44:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgEPve=BO=SOmgEOd4kv76bSbm0jWFzRzcs4Y7EedpgfA@mail.gmail.com>
X-Gm-Features: AWmQ_bkg_IidkR66xZb4S-deqo35yAvtxVL7xdWRUcGFEchFZ0rJJKEs7XvoLmY
Message-ID: <CAHk-=wgEPve=BO=SOmgEOd4kv76bSbm0jWFzRzcs4Y7EedpgfA@mail.gmail.com>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for tool-generated content
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Christian Brauner <brauner@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>, 
	"ksummit@lists.linux.dev" <ksummit@lists.linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Dan Williams <dan.j.williams@intel.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Nov 2025 at 09:25, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Mechanical transformations are often performed with Coccinelle. Given
> how you mention that tool below, I wouldn't frame it as out of scope
> here.

Honestly, I think the documented rule should not aim to treat AI as
anything special at all, and literally just talk about tooling.

Exactly because we've used things like coccinelle (and much simpler
tools like 'sed', for that matter) for ages.

IOW, this should all be about "tool-assisted patches should be
described as such, and should explain how the tool was used".

If people send in patches that have been generated by tools, we
already ask people to just include the script in the commit message.

I mean, we already have commit messages that say things like

    This is a completely mechanical patch (done with a simple "sed -i"
    statement).

when people do mindless conversions that are so straightforward that
the actual sed patch isn't even documented (in that case is was
something like just

   sed -i 's/__ASSEMBLY__/__ASSEMBLER__/'

or whatever), and in other cases people include the actual script
(random example being commit 96b451d53ae9: "drm/{i915,xe}: convert
i915 and xe display members into pointers").

I think we should treat any AI generated patches similarly: people
should mention the tool it was done with, and the script (ok, the
"scripts" are called "prompts", because AI is so "special") used.

Sure, AI ends up making the result potentially much more subtle, but I
don't think the *issue* is new, and I don't think it should need to be
treated as such.

                 Linus

