Return-Path: <linux-kernel+bounces-759794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B300B1E2BB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A48582E3E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8BA224AFB;
	Fri,  8 Aug 2025 07:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H8OuczV5"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EAB204F93
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754636442; cv=none; b=XFSoD+RxdaY4aBprrIXp6Qe32yEySAwGAPHMAAqw6jz0pKzPTBrpvbL7T9AIZqPazPW+HKsgJ++oSsGU35zT2NBfpczO+D2RgcMwX5CzLpLc30+4TjXTLm+h8nA1SXZxlVbzTXwbDLK/NOttKC70MZgnX/LjuQfVOwsuLixNAMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754636442; c=relaxed/simple;
	bh=EVo3hfbeuPKUpx3HiKtclFoPoJrpFgA+aUM1ynHlZmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFN51PGuNfEc2oVFwXvQ/aBIPBbb06G1jrS7E74kUtGXsSRiyBNjNmTdDPSd8//JevQDW4IpsXVSk8wivSXZ89Fi6UeogSAPu5d39Bf9jhJD44HbINKnUMZNpBfrwU1iVlK33b4K2fQa6fg8kp1Dx++k47OBa4uwQlOXUNMzIuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H8OuczV5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b7892609a5so1077698f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 00:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754636439; x=1755241239; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pVEu9GErkIXG3eJ2AqWu2ENhgTXDL/O6jQUo/mg7Ei4=;
        b=H8OuczV5c2frY8nzSZfjozNjQ6w5McLU6qpHfli22/7R/gH9ZJffDgFSAwkH0+JjIL
         1iWydbr4N2KJpvZD0JVYbQuhXLIyEt4zT1BGgA11CL8zmPpqX4q2qvXOWy3FSSZ3AKuU
         ntBuWJebiX+Je7fDRJG2ARR89Pzk/pHc5HwUmZapdJz2gEBySjbzEoZPXBbYVR6SfVoC
         JETKaS6SlvSvvwssKfNDTBYgU+SrqM/RnrwuQxWHJXH76R2DBTpOYYm6v4LgMq5TZyHg
         2yzSgPC8ZDyBMWKK8I9v+WZPIANkVLFG3MqFx2W8S0RqAK6HU31+BgSzwQhUzRblSV0G
         xJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754636439; x=1755241239;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVEu9GErkIXG3eJ2AqWu2ENhgTXDL/O6jQUo/mg7Ei4=;
        b=Z9oXULVhkhgucI+BnF3CoLDtenQ8Or5ung7dIuZag/66LImW3FEvev/3w/hMlvMdru
         vKEh7S0lAeFY/64tfPawbq/mt1wGBxcjD3mYbVidPYU/bXvMCyeBj5bDBC/rO0TyioyI
         PqyxgPaHZDgHnTSzNmprS/i3Us+hPSl5au1rKWfSz5BprTgtLoYMh79BUYsCka4oJQXq
         VTS7dwlKg3dZpvOdZWwDESH4axrtzbo+qai+PHG3mOCmJUjftS/aS8MQVnzqTm7YOFRt
         S5kQipNNS9gk3FybRq+WvTfkFR5ZWlQ7GDn/PJhG8zLkYdPI9JvwO1hI/wg+sLugkxIP
         c3hA==
X-Forwarded-Encrypted: i=1; AJvYcCVHd1DL4JufeCswxZSEEKJM9YNqon/id1l0GoHn1cvlhGsXlNQFYiT4N26xgdG7ByiwSytbEmu1mLtZ79c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCxzXQ4j/u5Ec9ensAoeaY5FFac3b8UGrdp1AofkAgpO+qE0kI
	0c4gpeQLv5SBzymtUiYPkOrosufYpVqJUoSACaTYPlOwLk6NhnKKeMfo/R2hiKdetKU=
X-Gm-Gg: ASbGnct6Gus7KwjSXKgu3jrEfu2trhwSvtzQ5aupWy+oYIRmEzTJ6kAIgFz5C+VJs8c
	clwHjCXvALdHeFRpZoziTToyHpU3WrfUyJxX6Ozpspl4lZu1ZVirMrQYK52suIPE8RvZud/ZnKA
	yuLfdeEUuYM2FeekiinOPduiU4P/zoW6oivzST8XEq+4JWviC7b1ddgTKAIWTFOI/LMfjCB382r
	70MyLfE7cyTazUU2adGfvP5tI++WsezxteAnL5e+UTGgXEOL93gf2YBdT9+vy24SF+nr+N7BKHl
	2r8poRE6bgBZgBS0MMRrYJjhJKa6ZtNvWIhw7vmo4v3yNDR5UWO7+ApeAVWC5sgu6ltjMMSL7En
	+zsOw3HlE2ZCeXBaE86uvi8iPI5xCnbY7aQ4=
X-Google-Smtp-Source: AGHT+IEJk4yevy9+HAy0KW8ZE8r8h3He+ydCFV/7Q/AXZWGxTkl97mbZhRDgapiuoxoRlq32dlvmJQ==
X-Received: by 2002:a05:6000:400b:b0:3b7:7cb5:a539 with SMTP id ffacd0b85a97d-3b900b2baa8mr1256578f8f.18.1754636438515;
        Fri, 08 Aug 2025 00:00:38 -0700 (PDT)
Received: from localhost (109-81-80-221.rct.o2.cz. [109.81.80.221])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e586a011sm133293865e9.19.2025.08.08.00.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 00:00:38 -0700 (PDT)
Date: Fri, 8 Aug 2025 09:00:37 +0200
From: Michal Hocko <mhocko@suse.com>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	len brown <len.brown@intel.com>, pavel machek <pavel@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nico Pache <npache@redhat.com>, xu xin <xu.xin16@zte.com.cn>,
	wangfushuai <wangfushuai@baidu.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Adrian Ratiu <adrian.ratiu@collabora.com>, linux-pm@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/9] freezer: Introduce freeze priority model to
 address process dependency issues
Message-ID: <aJWglTo1xpXXEqEM@tiehlicka>
References: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
 <aJSpTpB9_jijiO6m@tiehlicka>
 <4c46250f-eb0f-4e12-8951-89431c195b46@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c46250f-eb0f-4e12-8951-89431c195b46@kylinos.cn>

On Fri 08-08-25 09:13:30, Zihuan Zhang wrote:
[...]
> However, in practice, we’ve observed cases where tasks appear stuck in
> uninterruptible sleep (D state) during the freeze phase  — and thus cannot
> respond to signals or enter the refrigerator. These tasks are technically
> TASK_FREEZABLE, but due to the nature of their sleep state, they don’t
> freeze promptly, and may require multiple retry rounds, or cause the entire
> suspend to fail.

Right, but that is an inherent problem of the freezer implemenatation.
It is not really clear to me how priorities or layers improve on that.
Could you please elaborate on that?
-- 
Michal Hocko
SUSE Labs

