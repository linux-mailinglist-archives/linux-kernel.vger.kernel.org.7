Return-Path: <linux-kernel+bounces-891084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED69C41CA6
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894E81897509
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9D73126DD;
	Fri,  7 Nov 2025 22:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OyjGf8ud"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0773E3126CE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762552938; cv=none; b=A85RdoS33eAQn+SpFnIzu4x/u6V9EScj/WW4mNqwpKL9wsz3Jj8PiDnAGRhtQIDwP+/RiJhqt3MOXoRzkXm3ss3hAZtip5ep341LB1PA2TH1Su5tSkJSHjZlQSobKZyxhuCHcS9jdHudvKVY9HjwnRWN23Z+n+px1ukiiP0Kl3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762552938; c=relaxed/simple;
	bh=78h7gZjK2DnylzgjwC5RvW7XGitrHkh4zHw5oUqrXtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkDMhFCsdzZES7PKD6Qq0V+UzrZQUvAWPP9s5FZ2rraHyaFeBfhmDLHLq5D1jiZLPyw7HCsSbv6CCHgJ/zzdPF88rTKEYwWHCzXuPGipBoavB5JOriVlpu3uCbLzOLqiQP2SvHk3Xa+ufQEyAiuz9nDLTKSAuG38TiQ+BMpeo/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OyjGf8ud; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-294f3105435so17255ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 14:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762552936; x=1763157736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fk1g3IY/I26lAkkLzgmm3oJ8Y/bG9K9A/adrQZcZLLg=;
        b=OyjGf8uddzkjzKAUocFBRhMedIO4dx2j2LZmt9blNjf3mOEqnNctoGjHtdToDG1ZAO
         kRLFkF2tyjAS01SCMLA/8G7MLtNmIFzs/pM2PgNPYotEJUlpFV6YNOTrdggXBN5l4ZN9
         1b6n9oco17op/ewACcNtQYbfrwHBU5URq8PpSENpsWOu53qPsOBNxVc3ux4QAj/ewwOF
         P/x/A/C3LuNf/d1bgNC3332wdrWVn7ujo5hMXKL95uobkRvvcvpS/WnMlWn/pdpi/Kr1
         aqgRExgYCGQSnNgy44ZV180cfSMVmZMNVsd1YGuleWXKnqxKGukwE+RGyTUMxD1b7eI2
         g+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762552936; x=1763157736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fk1g3IY/I26lAkkLzgmm3oJ8Y/bG9K9A/adrQZcZLLg=;
        b=WN5irvVoBQGvcWwLvXzGHxq0P77ZbjbYeRBj4CdBGe3OfluuXuoAsBptQ1N3NLA9nj
         2A/3U2w1vqeRCGlplqetNkac22VxwhgkY+NA1rX5pmE11f6AeGQgPxSEhtJ8nZVcAH81
         bws0DG/iaJ/vTKIQKHnLpSBpcvBMtwTO8omvXLmWXfSEsuKLEn7hLJ9BpkxajFSsgfqo
         sg2+2zJnHqTSCWnPj9omlDGFuQe8pg5RCj9dEO1ytx8gscSEfyaG2JPqKVeaoSNRwMg5
         GzwjTapygZi0LO/JqIa+uHpNsWmOECKiJrqKmq+ODvdK4jPpkNXi2Hf+csv9MDn7kc09
         l1GA==
X-Forwarded-Encrypted: i=1; AJvYcCUivWwBHmLRa0tggAU55oR67RZpZkpaMYmY0RzItYUpY85rTDvfNGYmZ/6n0E+jYkPjj8Z2aGkntGBhf2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJhuOOeyUonRUhvHlv2IyGnAeNX8oRar/bMcK45239Op1emb2I
	po1AuVr4oSmcd8PAsmDCcmb1qrLxL4cfDGRu2ZqTDqI7SHsB7C5e4HC2nTdfqrxjnA==
X-Gm-Gg: ASbGncvjMhmwzuALVfxFMS/46a4B08LQFB92Y6LuoheBRmQ6WZBkvlIxiJLpqnAmoio
	5riEVbX90egLsz7KWjLgFUb/NJfLkCxqwFo/456ZOulJUwsK4/CCX8IR7sSDeEJicm4/vSlYhTn
	hVGa4Fw6BkgGPXW0L8XrniljQ9y7OZciEQQ6JDpIyoPjKVrZ1n2+HzdWVNZ/n5HqmcQKHtsS4De
	0qwuBLWRRb46GMQvoI7l7Qaj3J1yykeprtjAV5F0LVc1G0lUB1jb2j9U0gRaPb5P4NEoKeSQVLg
	DcIqcp53Ttrbce569/IWZ9Retnqimo1W7ZFaUWwrg1GzLAsbywqkmivQ9HWP8fI+K24FUOYSvO3
	MItxWEnXvyjqvN4rnTq4kri16Qmr5W/kf0J6S210B7Kxtpg5YcvzYUV0MhWuJGWYhIf/XSQvliV
	7hNIJb2FaKq7tcrMzm9gyEjQ6ESZHYP9PNXksrnxTGW411G00cRWYDUXVfU5F8CSQ+AZ1IcI0ba
	cq+CoVLHHe72lsK2Km2OCfGxg==
X-Google-Smtp-Source: AGHT+IE7LM/ftcbdlEIftAMc3LNqaSP97ukQV1UpBEOmW69D8muqPSdkZcVrRCXHkPez2e+AUj0Wfw==
X-Received: by 2002:a17:903:190:b0:26a:8171:daf8 with SMTP id d9443c01a7336-297e567e77amr1470925ad.8.1762552935873;
        Fri, 07 Nov 2025 14:02:15 -0800 (PST)
Received: from google.com (116.241.118.34.bc.googleusercontent.com. [34.118.241.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297dacd1e93sm11822995ad.2.2025.11.07.14.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:02:14 -0800 (PST)
Date: Fri, 7 Nov 2025 22:02:09 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust_binder: move BC_FREE_BUFFER drop inside if statement
Message-ID: <aQ5sYW7B9riNRNHI@google.com>
References: <20251029-binder-bcfreebuf-option-v1-1-4d282be0439f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-binder-bcfreebuf-option-v1-1-4d282be0439f@google.com>

On Wed, Oct 29, 2025 at 11:50:58AM +0000, Alice Ryhl wrote:
> When looking at flamegraphs, there is a pretty large entry for the
> function call drop_in_place::<Option<Allocation>> which in turn calls
> drop_in_place::<Allocation>. Combined with the looper_need_return
> condition, this means that the generated code looks like this:
> 
> 	if let Some(buffer) = buffer {
> 	    if buffer.looper_need_return_on_free() {
> 	        self.inner.lock().looper_need_return = true;
> 	    }
> 	}
> 	drop_in_place::<Option<Allocation>>() { // not inlined
> 	    if let Some(buffer) = buffer {
> 	    	drop_in_place::<Allocation>(buffer);
> 	    }
> 	}
> 
> This kind of situation where you check X and then check X again is
> normally optimized into a single condition, but in this case due to the
> non-inlined function call to drop_in_place::<Option<Allocation>>, that
> optimization does not happen.
> 
> Furthermore, the drop_in_place::<Allocation> call is only two-thirds of
> the drop_in_place::<Option<Allocation>> call in the flamegraph. This
> indicates that this double condition is not performing well. Also, last
> time I looked at Binder perf, I remember finding that the destructor of
> Allocation was involved with many branch mispredictions.
> 
> Thus, change this code to look like this:
> 
> 	if let Some(buffer) = buffer {
> 	    if buffer.looper_need_return_on_free() {
> 	        self.inner.lock().looper_need_return = true;
> 	    }
> 	    drop_in_place::<Allocation>(buffer);
> 	}
> 
> by dropping the Allocation directly. Flamegraphs confirm that the
> drop_in_place::<Option<Allocation>> call disappears from this change.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

LGTM,

Acked-by: Carlos Llamas <cmllamas@google.com>

