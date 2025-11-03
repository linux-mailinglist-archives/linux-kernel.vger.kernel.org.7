Return-Path: <linux-kernel+bounces-883460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39292C2D803
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CAAF4E7429
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974E231BCA6;
	Mon,  3 Nov 2025 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HcPmR/an"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90FF1EA84
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762191510; cv=none; b=DeSq/0yZVdEIU3zNbRx7n33dixdJ2YbfZdS3IrYQmWCbyfQ1yv95yT+HaXXJQt8tXQ8mSwUNFYSXEoTq2qyBBYy73Qs5nt0L6PoKHqgXz/DAJ0UOCaDKdLf8knQcfw+tvA2KDmJf7UvJfB2E4yLt2WUL+jnATIbE3QXmAV88zL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762191510; c=relaxed/simple;
	bh=vJRMennsWCct9m2guUQFebnO7qEvNUlkcCKrxaZwKhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzUR1HAZ5ChvMrH8VOiB/WFxs75dzFQeX5HBUBN25KvC5UyrFXvuD2mrOasAX6WEc4eR4/0vou8j8IfxyzfghKcVP1aRygld+9hQb8yfFROuFBHLLPpD296N5aM59s7qELnAiLPJmDjbIdseXIdtN7O6IKzzMENVXF5OEVRMZt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HcPmR/an; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640741cdda7so5918626a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762191506; x=1762796306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nKme4EHGcK/96zCcssiCbHFkH/8vf7rscVYZBXnQmv8=;
        b=HcPmR/anNQaashbDErSxRYSVGjFe1M/erIQ2ggLnbRph+0Fftyd+Pd43+Id+1A69Ze
         pqvApsvJx0dKpf3YZ4g1Smb6nCIJy9shad8iO7DTXHO4RDH6y7k2NK9djzZMF+pL2EJL
         +O1Lz+aL4yzSgmgNnqMK5mN37Kaijm0KeRXO6lNak1yjQpTdVvJTc/ygxr0KVJd7ZBhb
         hZcOABRdzqdPPt+tXtsXVdgkDy4xLeufNzub7kIkpH6lNandmVHqmYjTcqMFPNTYGqDp
         d2v/RA70do6j3KZ4KTX/T8BzISpLnCOSrAa0gSP/vnKakQOKMWbdEL1EsuZzml9X+xlb
         nT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762191506; x=1762796306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKme4EHGcK/96zCcssiCbHFkH/8vf7rscVYZBXnQmv8=;
        b=PNeQcUvvcZYJPh0OvMEPc2qlG1MRzNJcyj12T5aMrNtwpeGEDlwAXdu1UfZEZhd4YI
         1AwznyXcw3oXO6L5ZJRN1AKKux64Gh9LEavlZXveiqwInu06f9wMu5ru5IZNCrlTEF8c
         Rpbl/z0bf9P6jTfKWJMvSE/b8VUiE/2MghbDYa4V5mx1ucFlevnEJnNjcIJlTfWWvHPy
         a59j5uozl+BVyUO8mEjY4CGRo+8Tle+arEy6VMAPyrR3640yw39TD2n61og/qLt33+CS
         8gFk+RUw6DCePew6bEhgG6Nb5FxDUwXpNXElLVOV9yz+8Wj4ejJ/RLoa2hq4ZFHL0Sp3
         aDBA==
X-Forwarded-Encrypted: i=1; AJvYcCW2uZPzVsff5MVYymV6zEsOzNMav9CL9vMfpJyz66dWJSiR/Dj7dL4WzS/1CmQ9+gN6STkf+H+s38G0A10=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjhcREDypDxq1vrFPHwnwCc5mr49ZAJHzcrAwy6JOWmIWVPzyh
	xGq+vHPGnRLjmpqvwYT8J+7RTruEaErdHeQy10jltY9DXUgBJWX5OFc8tU0qtw8aZxCPyMtT2es
	Kjx4H
X-Gm-Gg: ASbGncs2IoYvAG34Y6W37Nn75qfCOudGno7JTNelBYqIRLAG1R5bK0LIEMyWEt1K94c
	zZRkwtztNF6lk4CsKa4R3T/kQl9Ab6xydTjLie6kgEn3RO/fxw+yXPIaK36ZsU9XjngpxZZPXye
	U/+CmQGY0nPF5UlwtBWfDQ8wiZUC5CbdDz8SDbWXbTHrKitgqm1X2jL6fGAXoNIxr7zk4mWcrPD
	0eN9M7ygJnisG6wDSj3VWpkvPAaQkcVeglKWCym2sOY335Tl7QoSXUcDa8EMRNUDR0CKlm/FSbd
	5n40cgXB3vFpQOEJ9BK1iZNA8u65b70Xx/tblVhCXYi/m6sgQwkkOO1KMF61cosudlk1XIWzW0O
	GsoNeok1xxO57+BErNzTqplU3xaBuCLBd5VnWNURKaxJRL/JMvmXU/qF+RWM9X+oDgwiywMjVMM
	QALr0P8LQz3Ed1ug==
X-Google-Smtp-Source: AGHT+IHZU9B6/1PQT3A3NSjlIoomPkpMldgmq3DhKUzR1A/lj5cN5pQjDj3PXAdArLteEOX+cIg7kQ==
X-Received: by 2002:a05:6402:510c:b0:63e:209b:a958 with SMTP id 4fb4d7f45d1cf-64077015d1bmr12196616a12.17.1762191506079;
        Mon, 03 Nov 2025 09:38:26 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64093b3868esm8194908a12.28.2025.11.03.09.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:38:25 -0800 (PST)
Date: Mon, 3 Nov 2025 18:38:23 +0100
From: Petr Mladek <pmladek@suse.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] lib/vsprintf: Improve vsprintf + sprintf function
 comments
Message-ID: <aQjojzD4xJOuLuAD@pathway.suse.cz>
References: <20251103090913.2066-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103090913.2066-2-thorsten.blum@linux.dev>

On Mon 2025-11-03 10:09:13, Thorsten Blum wrote:
> Clarify that the return values of vsprintf() and sprintf() exclude the
> trailing NUL character.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I am sorry that the first email somehow slipped though the cracks.

