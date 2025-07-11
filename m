Return-Path: <linux-kernel+bounces-728299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C04D9B02642
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658703BB446
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B142288E3;
	Fri, 11 Jul 2025 21:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2HlG1hS"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6610F1C3C11
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752268664; cv=none; b=a5kqD+se3wDhTR/d91ELXwnyhm4WSRliOqwmuawcqzLVjatXMdLqvOjv/ghYrU4b5bMLH5vmf92La1MWmoNqMyRFf1QB+Juqg5uUks0YUPH5b+9FLulnLzy7tI2gO6TD4ATmiGz29w+Q5ymBMgiky5bgDScaMWcKw35qcn+6ptg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752268664; c=relaxed/simple;
	bh=YePCEHIopDep3DTEIBs99pjrezBGTdmFfLVyOTwC+NM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJZFl5lVQfNFZwPWfuHnpzLQEvDx0LinD2hIE1yFMap4fbseH3LTG0sIi7H6GILjoCMdWidOWMqnTFlG/gMX5nAK49M6dI+5EnikL3mvRmBpIqKJIYS5jfILGlokRapipeFuSqN34TxMiqWI6oi2cdZOMXe4ivFwXq/64x5nNa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2HlG1hS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so1694593f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752268660; x=1752873460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3rMwyP/oyX4LKPJlR8ETWcOj/+MICSc/XLMI73djsM=;
        b=K2HlG1hSudtGqlyni5eaJa8X+FHuoaXyd5hcJXbuk7aajCl0nvLeiatfLnmpYG5cpT
         5MO5sIjoFEtlgKmWFGKRW0bfGTfvJ3oIMQT6ixU/iPdgDvon1gYxkAN7Cu8Sum8ToXZk
         vU0EtEldE5H037uWRmOtbD+EP+eUKn/5tntuQnMAotYo6UbCJ7R0H7a6H2XXpRbV/6io
         iqhPMAy9IMr9cOiv5Q6TgS/Vs4wWxtIjMobg6aLYy71HT1AyaNfjaWWvhZPQrJw2Vgrq
         NQv1hoLPEFc+m0tyqN7W6R4md0eF+YJx9FFzAbm7hndglHHzwwJwntNxM+kwJ1wcp++8
         pCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752268660; x=1752873460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3rMwyP/oyX4LKPJlR8ETWcOj/+MICSc/XLMI73djsM=;
        b=LeAGrrMfbzb1hDtNzasBzesVA/W3f26Su2Eyu5LWRhC5LtT9w3X6KQc485CrKM+/6a
         /7K50pouyb0oqKbPeBvCP/ayxhvBnCBe+njj59/GS0kyitsne+0LLUxTVCmeWD3OHfcH
         wwUzqrjJ2LiwS9Wfgogy7a7O9HHGT/P33fz6CF7G0gJSaBRIwhbBgroSiMb/CtV6snFp
         nLsJyr4gIcZEdoLoCSK53wSzgFcP29ouhSuxq5PBT+1xVJSrRYEisenI9G/nG1C2fgT+
         34Y3WLYpAfO7XZ8nu5dlYBCjzyIRLhhxD5MYWIEEUOvYcY3NtN0jTFv8rT4p/cwPnjF5
         2k6A==
X-Forwarded-Encrypted: i=1; AJvYcCUUP2u2gZsL6vzws6Kshd7YYY9Bkvg8uQvppUq8Nxqlv7J1RGe8XxuobWl0+vAkuWINdrYn649va8uJekQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWcq0vaAtF2FYFDyaTpZPjukgbu2jiG+SjtMGp/FbSJb607RGo
	HYqmKPHQdvwjNjeSFjvDxvVLzIL4W/bXExUx7nKLcNjpXSYzFe+o7YfU
X-Gm-Gg: ASbGncu+EKt+SMji1L1PUcau2swtJqMohxXWjKIptVfYXD6PYXr9veVE5WS2q2kULJa
	L5vwUSDkw7k3O3IrPx4nqgDzSY6aoAW9t67Qpe7kkzS/Kh58PTfmIFvVttNawj9TptyFAP63bY1
	mzH2WXrVPo3jgDm0YUxUtaoE5zijsrj8dISaqFSWPDLHcxxywDCXeMpa2OwTjfdyYNGbG60eqMa
	qhwnm+2QIrXoCswGsI4gDhddBIjK88BAErTH6TFo5+XU9zps5hUms9Buunrqo6c9a97rkGCH5/m
	Skc7n8nLL2NBjVrumWEE7bvri8B7D4EG4IdiKn6BP45kFp2Fm/VbhkS6Tyd+3/LQzQ88djuQ86W
	0ZPsaYt33IfniXe2F8a27XOoIwTM4D0dMchb15vnMpG8ebnIn91trsA==
X-Google-Smtp-Source: AGHT+IEghPJe1XiS+Efs9SEzNm3QfAKOapSbPcYokp8DCukUhr0AS5OCgK53Oaxt09DTbF3xmCuntA==
X-Received: by 2002:a5d:5888:0:b0:3a5:1241:afde with SMTP id ffacd0b85a97d-3b5f1c722dcmr4498838f8f.9.1752268659348;
        Fri, 11 Jul 2025 14:17:39 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14cfcsm5544067f8f.67.2025.07.11.14.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 14:17:39 -0700 (PDT)
Date: Fri, 11 Jul 2025 22:17:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: u.kleine-koenig@baylibre.com, Nicolas Pitre <npitre@baylibre.com>, Oleg
 Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Biju Das
 <biju.das.jz@bp.renesas.com>, rostedt@goodmis.org, lirongqing@baidu.com
Subject: Re: [PATCH v3 next 09/10] lib: mul_u64_u64_div_u64() Optimise the
 divide code
Message-ID: <20250711221715.37b0384b@pumpkin>
In-Reply-To: <20250709152420.4c95c22d@pumpkin>
References: <20250614095346.69130-1-david.laight.linux@gmail.com>
	<20250614095346.69130-10-david.laight.linux@gmail.com>
	<20250709152420.4c95c22d@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 15:24:20 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> On Sat, 14 Jun 2025 10:53:45 +0100
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> > Replace the bit by bit algorithm with one that generates 16 bits
> > per iteration on 32bit architectures and 32 bits on 64bit ones.  
> 
> I've spent far too long doing some clock counting exercises on this code.
> This is the latest version with some conditional compiles and comments
> explaining the various optimisation.
> I think the 'best' version is with -DMULDIV_OPT=0xc3
> 
>....
> Some measurements on an ivy bridge.
> These are the test vectors from the test module with a few extra values on the
> end that pick different paths through this implementatoin.
> The numbers are 'performance counter' deltas for 10 consecutive calls with the
> same values.
> So the latter values are with the branch predictor 'trained' to the test case.
> The first few (larger) values show the cost of mispredicted branches.

I should have included the values for the sames tests with the existing code.
Added here, but this is includes the change to test for overflow and divide
by zero after the multiply (no ilog2 calls - which make the 32bit code worse).
About the only cases where the old code it better are when the quotient
only has two bits set.

> Apologies for the very long lines.
> 
> $ cc -O2 -o div_perf div_perf.c -DMULDIV_OPT=0xc3  && sudo ./div_perf
> 0: ok   162   134    78    78    78    78    78    80    80    80 mul_u64_u64_div_u64_new b*7/3 = 19
> 1: ok    91    91    91    91    91    91    91    91    91    91 mul_u64_u64_div_u64_new ffff0000*ffff0000/f = 1110eeef00000000
> 2: ok    75    77    75    77    77    77    77    77    77    77 mul_u64_u64_div_u64_new ffffffff*ffffffff/1 = fffffffe00000001
> 3: ok    89    91    91    91    91    91    89    90    91    91 mul_u64_u64_div_u64_new ffffffff*ffffffff/2 = 7fffffff00000000
> 4: ok   147   147   128   128   128   128   128   128   128   128 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/2 = fffffffe80000000
> 5: ok   128   128   128   128   128   128   128   128   128   128 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/3 = aaaaaaa9aaaaaaab
> 6: ok   121   121   121   121   121   121   121   121   121   121 mul_u64_u64_div_u64_new 1ffffffff*1ffffffff/4 = ffffffff00000000
> 7: ok   274   234   146   138   138   138   138   138   138   138 mul_u64_u64_div_u64_new ffff000000000000*ffff000000000000/ffff000000000001 = fffeffffffffffff
> 8: ok   177   148   148   149   149   149   149   149   149   149 mul_u64_u64_div_u64_new 3333333333333333*3333333333333333/5555555555555555 = 1eb851eb851eb851
> 9: ok   138    90   118    91    91    91    91    92    92    92 mul_u64_u64_div_u64_new 7fffffffffffffff*2/3 = 5555555555555554
> 10: ok   113   114    86    86    84    86    86    84    87    87 mul_u64_u64_div_u64_new ffffffffffffffff*2/8000000000000000 = 3
> 11: ok    87    88    88    86    88    88    88    88    90    90 mul_u64_u64_div_u64_new ffffffffffffffff*2/c000000000000000 = 2
> 12: ok    82    86    84    86    83    86    83    86    83    87 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000004/8000000000000000 = 8000000000000007
> 13: ok    82    86    84    86    83    86    83    86    83    86 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000001/8000000000000000 = 8000000000000001
> 14: ok   189   187   138   132   132   132   131   131   131   131 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/ffffffffffffffff = 8000000000000001
> 15: ok   221   175   159   131   131   131   131   131   131   131 mul_u64_u64_div_u64_new fffffffffffffffe*8000000000000001/ffffffffffffffff = 8000000000000000
> 16: ok   134   132   134   134   134   135   134   134   134   134 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffe = 8000000000000001
> 17: ok   172   134   137   134   134   134   134   134   134   134 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffd = 8000000000000002
> 18: ok   182   182   129   129   129   129   129   129   129   129 mul_u64_u64_div_u64_new 7fffffffffffffff*ffffffffffffffff/c000000000000000 = aaaaaaaaaaaaaaa8
> 19: ok   130   129   130   129   129   129   129   129   129   129 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/a000000000000000 = ccccccccccccccca
> 20: ok   130   129   129   129   129   129   129   129   129   129 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/9000000000000000 = e38e38e38e38e38b
> 21: ok   130   129   129   129   129   129   129   129   129   129 mul_u64_u64_div_u64_new 7fffffffffffffff*7fffffffffffffff/5000000000000000 = ccccccccccccccc9
> 22: ok   206   140   138   138   138   138   138   138   138   138 mul_u64_u64_div_u64_new ffffffffffffffff*fffffffffffffffe/ffffffffffffffff = fffffffffffffffe
> 23: ok   174   140   138   138   138   138   138   138   138   138 mul_u64_u64_div_u64_new e6102d256d7ea3ae*70a77d0be4c31201/d63ec35ab3220357 = 78f8bf8cc86c6e18
> 24: ok   135   137   137   137   137   137   137   137   137   137 mul_u64_u64_div_u64_new f53bae05cb86c6e1*3847b32d2f8d32e0/cfd4f55a647f403c = 42687f79d8998d35
> 25: ok   134   136   136   136   136   136   136   136   136   136 mul_u64_u64_div_u64_new 9951c5498f941092*1f8c8bfdf287a251/a3c8dc5f81ea3fe2 = 1d887cb25900091f
> 26: ok   136   134   134   134   134   134   134   134   134   134 mul_u64_u64_div_u64_new 374fee9daa1bb2bb*d0bfbff7b8ae3ef/c169337bd42d5179 = 3bb2dbaffcbb961
> 27: ok   139   138   138   138   138   138   138   138   138   138 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
> 28: ok   130   143    95    95    96    96    96    96    96    96 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/d63ec35ab3220357 = 1a599d6e
> 29: ok   169   158   158   138   138   138   138   138   138   138 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
> 30: ok   178   164   144   147   147   147   147   147   147   147 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/63ec35ab3220357 = 387f55cef
> 31: ok   163   128   128   128   128   128   128   128   128   128 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb000000000000 = dc5f7e8b334db07d
> 32: ok   163   184   137   136   136   138   138   138   138   138 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
> 
> $ cc -O2 -o div_perf div_perf.c -DMULDIV_OPT=0x03  && sudo ./div_perf
> 0: ok   125    78    78    79    79    79    79    79    79    79 mul_u64_u64_div_u64_new b*7/3 = 19
> 1: ok    88    89    89    88    89    89    89    89    89    89 mul_u64_u64_div_u64_new ffff0000*ffff0000/f = 1110eeef00000000
> 2: ok    75    76    76    76    76    76    74    76    76    76 mul_u64_u64_div_u64_new ffffffff*ffffffff/1 = fffffffe00000001
> 3: ok    87    89    89    89    89    89    89    88    88    88 mul_u64_u64_div_u64_new ffffffff*ffffffff/2 = 7fffffff00000000
> 4: ok   305   221   148   144   147   147   147   147   147   147 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/2 = fffffffe80000000
> 5: ok   179   178   141   141   141   141   141   141   141   141 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/3 = aaaaaaa9aaaaaaab
> 6: ok   148   200   143   145   145   145   145   145   145   145 mul_u64_u64_div_u64_new 1ffffffff*1ffffffff/4 = ffffffff00000000
> 7: ok   201   186   140   135   135   135   135   135   135   135 mul_u64_u64_div_u64_new ffff000000000000*ffff000000000000/ffff000000000001 = fffeffffffffffff
> 8: ok   227   154   145   141   141   141   141   141   141   141 mul_u64_u64_div_u64_new 3333333333333333*3333333333333333/5555555555555555 = 1eb851eb851eb851
> 9: ok   111   111    89    89    89    89    89    89    89    89 mul_u64_u64_div_u64_new 7fffffffffffffff*2/3 = 5555555555555554
> 10: ok   149   156   124    90    90    90    90    90    90    90 mul_u64_u64_div_u64_new ffffffffffffffff*2/8000000000000000 = 3
> 11: ok    91    91    90    90    90    90    90    90    90    90 mul_u64_u64_div_u64_new ffffffffffffffff*2/c000000000000000 = 2
> 12: ok   197   197   138   134   134   134   134   134   134   134 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000004/8000000000000000 = 8000000000000007
> 13: ok   260   136   136   135   135   135   135   135   135   135 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000001/8000000000000000 = 8000000000000001
> 14: ok   186   187   164   130   127   127   127   127   127   127 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/ffffffffffffffff = 8000000000000001
> 15: ok   171   172   173   158   160   128   125   127   125   127 mul_u64_u64_div_u64_new fffffffffffffffe*8000000000000001/ffffffffffffffff = 8000000000000000
> 16: ok   157   164   129   130   130   130   130   130   130   130 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffe = 8000000000000001
> 17: ok   191   158   130   132   132   130   130   130   130   130 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffd = 8000000000000002
> 18: ok   197   214   163   138   138   138   138   138   138   138 mul_u64_u64_div_u64_new 7fffffffffffffff*ffffffffffffffff/c000000000000000 = aaaaaaaaaaaaaaa8
> 19: ok   196   196   135   134   134   134   134   134   134   134 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/a000000000000000 = ccccccccccccccca
> 20: ok   191   216   176   140   138   138   138   138   138   138 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/9000000000000000 = e38e38e38e38e38b
> 21: ok   232   157   156   145   145   145   145   145   145   145 mul_u64_u64_div_u64_new 7fffffffffffffff*7fffffffffffffff/5000000000000000 = ccccccccccccccc9
> 22: ok   159   192   133   134   134   134   134   134   134   134 mul_u64_u64_div_u64_new ffffffffffffffff*fffffffffffffffe/ffffffffffffffff = fffffffffffffffe
> 23: ok   133   134   134   134   134   134   134   134   134   134 mul_u64_u64_div_u64_new e6102d256d7ea3ae*70a77d0be4c31201/d63ec35ab3220357 = 78f8bf8cc86c6e18
> 24: ok   134   131   131   131   131   134   131   131   131   131 mul_u64_u64_div_u64_new f53bae05cb86c6e1*3847b32d2f8d32e0/cfd4f55a647f403c = 42687f79d8998d35
> 25: ok   133   130   130   130   130   130   130   130   130   130 mul_u64_u64_div_u64_new 9951c5498f941092*1f8c8bfdf287a251/a3c8dc5f81ea3fe2 = 1d887cb25900091f
> 26: ok   133   130   130   130   130   130   130   130   130   131 mul_u64_u64_div_u64_new 374fee9daa1bb2bb*d0bfbff7b8ae3ef/c169337bd42d5179 = 3bb2dbaffcbb961
> 27: ok   133   134   134   134   134   134   134   134   134   133 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
> 28: ok   151    93   119    93    93    93    93    93    93    93 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/d63ec35ab3220357 = 1a599d6e
> 29: ok   193   137   134   134   134   134   134   134   134   134 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
> 30: ok   194   151   150   137   137   137   137   137   137   137 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/63ec35ab3220357 = 387f55cef
> 31: ok   137   173   172   137   138   138   138   138   138   138 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb000000000000 = dc5f7e8b334db07d
> 32: ok   160   149   131   134   134   134   134   134   134   134 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
> 
> $ cc -O2 -o div_perf div_perf.c -DMULDIV_OPT=0x24  && sudo ./div_perf
> 0: ok   130   106    79    79    78    78    78    78    81    81 mul_u64_u64_div_u64_new b*7/3 = 19
> 1: ok    88    92    92    89    92    92    92    92    91    91 mul_u64_u64_div_u64_new ffff0000*ffff0000/f = 1110eeef00000000
> 2: ok    74    78    78    78    78    78    75    79    78    78 mul_u64_u64_div_u64_new ffffffff*ffffffff/1 = fffffffe00000001
> 3: ok    87    92    92    92    92    92    92    92    92    92 mul_u64_u64_div_u64_new ffffffff*ffffffff/2 = 7fffffff00000000
> 4: ok   330   275   181   145   147   148   148   148   148   148 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/2 = fffffffe80000000
> 5: ok   225   175   141   146   146   146   146   146   146   146 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/3 = aaaaaaa9aaaaaaab
> 6: ok   187   194   193   194   178   144   148   148   148   148 mul_u64_u64_div_u64_new 1ffffffff*1ffffffff/4 = ffffffff00000000
> 7: ok   202   189   178   139   140   139   140   139   140   139 mul_u64_u64_div_u64_new ffff000000000000*ffff000000000000/ffff000000000001 = fffeffffffffffff
> 8: ok   228   168   150   143   143   143   143   143   143   143 mul_u64_u64_div_u64_new 3333333333333333*3333333333333333/5555555555555555 = 1eb851eb851eb851
> 9: ok   112   112    92    89    92    92    92    92    92    87 mul_u64_u64_div_u64_new 7fffffffffffffff*2/3 = 5555555555555554
> 10: ok   153   184    92    93    95    95    95    95    95    95 mul_u64_u64_div_u64_new ffffffffffffffff*2/8000000000000000 = 3
> 11: ok   158    93    93    93    95    92    95    95    95    95 mul_u64_u64_div_u64_new ffffffffffffffff*2/c000000000000000 = 2
> 12: ok   206   178   146   139   139   140   139   140   139   140 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000004/8000000000000000 = 8000000000000007
> 13: ok   187   146   140   139   140   139   140   139   140   139 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000001/8000000000000000 = 8000000000000001
> 14: ok   167   173   136   136   102    97    97    97    97    97 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/ffffffffffffffff = 8000000000000001
> 15: ok   166   150   105    98    98    98    97    99    97    99 mul_u64_u64_div_u64_new fffffffffffffffe*8000000000000001/ffffffffffffffff = 8000000000000000
> 16: ok   209   197   139   136   136   136   136   136   136   136 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffe = 8000000000000001
> 17: ok   170   142   170   137   136   135   136   135   136   135 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffd = 8000000000000002
> 18: ok   238   197   172   140   140   140   139   141   140   139 mul_u64_u64_div_u64_new 7fffffffffffffff*ffffffffffffffff/c000000000000000 = aaaaaaaaaaaaaaa8
> 19: ok   185   206   139   141   142   142   142   142   142   142 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/a000000000000000 = ccccccccccccccca
> 20: ok   207   226   146   142   140   140   140   140   140   140 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/9000000000000000 = e38e38e38e38e38b
> 21: ok   161   153   148   148   148   148   148   148   148   146 mul_u64_u64_div_u64_new 7fffffffffffffff*7fffffffffffffff/5000000000000000 = ccccccccccccccc9
> 22: ok   172   199   141   140   140   140   140   140   140   140 mul_u64_u64_div_u64_new ffffffffffffffff*fffffffffffffffe/ffffffffffffffff = fffffffffffffffe
> 23: ok   172   137   140   140   140   140   140   140   140   140 mul_u64_u64_div_u64_new e6102d256d7ea3ae*70a77d0be4c31201/d63ec35ab3220357 = 78f8bf8cc86c6e18
> 24: ok   135   138   138   138   138   138   138   138   138   138 mul_u64_u64_div_u64_new f53bae05cb86c6e1*3847b32d2f8d32e0/cfd4f55a647f403c = 42687f79d8998d35
> 25: ok   136   137   137   137   137   137   137   137   137   137 mul_u64_u64_div_u64_new 9951c5498f941092*1f8c8bfdf287a251/a3c8dc5f81ea3fe2 = 1d887cb25900091f
> 26: ok   136   136   136   136   136   136   136   136   136   136 mul_u64_u64_div_u64_new 374fee9daa1bb2bb*d0bfbff7b8ae3ef/c169337bd42d5179 = 3bb2dbaffcbb961
> 27: ok   139   140   140   140   140   140   140   140   140   140 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
> 28: ok   132    94    97    96    96    96    96    96    96    96 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/d63ec35ab3220357 = 1a599d6e
> 29: ok   139   140   140   140   140   140   140   140   140   140 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
> 30: ok   159   141   141   141   141   141   141   141   141   141 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/63ec35ab3220357 = 387f55cef
> 31: ok   244   186   154   141   139   141   140   139   141   140 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb000000000000 = dc5f7e8b334db07d
> 32: ok   165   140   140   140   140   140   140   140   140   140 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216

Existing code, 64bit x86
$ cc -O2 -o div_perf div_perf.c  && sudo ./div_perf
0: ok   171   117    88    89    88    87    87    87    90    88 mul_u64_u64_div_u64 b*7/3 = 19
1: ok    98    97    97    97   101   101   101   101   101   101 mul_u64_u64_div_u64 ffff0000*ffff0000/f = 1110eeef00000000
2: ok    85    85    84    84    84    87    87    87    87    87 mul_u64_u64_div_u64 ffffffff*ffffffff/1 = fffffffe00000001
3: ok    99   101   101   101   101    99   101   101   101   101 mul_u64_u64_div_u64 ffffffff*ffffffff/2 = 7fffffff00000000
4: ok   162   145    90    90    90    90    90    90    90    90 mul_u64_u64_div_u64 1ffffffff*ffffffff/2 = fffffffe80000000
5: ok   809   675   582   462   450   446   442   446   446   450 mul_u64_u64_div_u64 1ffffffff*ffffffff/3 = aaaaaaa9aaaaaaab
6: ok   136    90    90    90    90    90    90    90    90    90 mul_u64_u64_div_u64 1ffffffff*1ffffffff/4 = ffffffff00000000
7: ok   559   449   391   370   374   370   394   377   375   384 mul_u64_u64_div_u64 ffff000000000000*ffff000000000000/ffff000000000001 = fffeffffffffffff
8: ok   587   515   386   333   334   334   334   334   334   334 mul_u64_u64_div_u64 3333333333333333*3333333333333333/5555555555555555 = 1eb851eb851eb851
9: ok   124   123    99    99   101   101   101   101   101   101 mul_u64_u64_div_u64 7fffffffffffffff*2/3 = 5555555555555554
10: ok   143   119    93    90    90    90    90    90    90    90 mul_u64_u64_div_u64 ffffffffffffffff*2/8000000000000000 = 3
11: ok   136    93    93    95    93    93    93    93    93    93 mul_u64_u64_div_u64 ffffffffffffffff*2/c000000000000000 = 2
12: ok    88    90    90    90    90    90    93    90    90    90 mul_u64_u64_div_u64 ffffffffffffffff*4000000000000004/8000000000000000 = 8000000000000007
13: ok    88    90    90    90    90    90    90    90    90    90 mul_u64_u64_div_u64 ffffffffffffffff*4000000000000001/8000000000000000 = 8000000000000001
14: ok   138   144   102   122   101    71    73    74    74    74 mul_u64_u64_div_u64 ffffffffffffffff*8000000000000001/ffffffffffffffff = 8000000000000001
15: ok   101    98    95    98    93    66    69    69    69    69 mul_u64_u64_div_u64 fffffffffffffffe*8000000000000001/ffffffffffffffff = 8000000000000000
16: ok   207   169   124    99    76    75    76    76    76    76 mul_u64_u64_div_u64 ffffffffffffffff*8000000000000001/fffffffffffffffe = 8000000000000001
17: ok   177   143   107   108    76    74    74    74    74    74 mul_u64_u64_div_u64 ffffffffffffffff*8000000000000001/fffffffffffffffd = 8000000000000002
18: ok   565   444   412   399   401   413   399   412   392   415 mul_u64_u64_div_u64 7fffffffffffffff*ffffffffffffffff/c000000000000000 = aaaaaaaaaaaaaaa8
19: ok   411   447   435   392   417   398   422   394   402   394 mul_u64_u64_div_u64 ffffffffffffffff*7fffffffffffffff/a000000000000000 = ccccccccccccccca
20: ok   467   452   450   427   405   428   418   413   421   405 mul_u64_u64_div_u64 ffffffffffffffff*7fffffffffffffff/9000000000000000 = e38e38e38e38e38b
21: ok   443   395   398   417   405   418   398   404   404   404 mul_u64_u64_div_u64 7fffffffffffffff*7fffffffffffffff/5000000000000000 = ccccccccccccccc9
22: ok   441   400   363   361   347   348   345   345   345   343 mul_u64_u64_div_u64 ffffffffffffffff*fffffffffffffffe/ffffffffffffffff = fffffffffffffffe
23: ok   895   811   423   348   352   352   352   352   352   352 mul_u64_u64_div_u64 e6102d256d7ea3ae*70a77d0be4c31201/d63ec35ab3220357 = 78f8bf8cc86c6e18
24: ok   928   638   445   339   344   344   344   344   344   344 mul_u64_u64_div_u64 f53bae05cb86c6e1*3847b32d2f8d32e0/cfd4f55a647f403c = 42687f79d8998d35
25: ok   606   457   277   279   276   276   276   276   276   276 mul_u64_u64_div_u64 9951c5498f941092*1f8c8bfdf287a251/a3c8dc5f81ea3fe2 = 1d887cb25900091f
26: ok   955   683   415   377   377   377   377   377   377   377 mul_u64_u64_div_u64 374fee9daa1bb2bb*d0bfbff7b8ae3ef/c169337bd42d5179 = 3bb2dbaffcbb961
27: ok   700   599   375   382   382   382   382   382   382   382 mul_u64_u64_div_u64 eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
28: ok   406   346   238   238   217   214   214   214   214   214 mul_u64_u64_div_u64 2d256d7ea3ae*7d0be4c31201/d63ec35ab3220357 = 1a599d6e
29: ok   486   380   378   382   382   382   382   382   382   382 mul_u64_u64_div_u64 eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
30: ok   538   407   297   262   244   244   244   244   244   244 mul_u64_u64_div_u64 2d256d7ea3ae*7d0be4c31201/63ec35ab3220357 = 387f55cef
31: ok   564   539   446   451   417   418   424   425   417   425 mul_u64_u64_div_u64 eac0d03ac10eeaf0*89be05dfa162ed9b/92bb000000000000 = dc5f7e8b334db07d
32: ok   416   382   387   382   382   382   382   382   382   382 mul_u64_u64_div_u64 eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216


> 
> $ cc -O2 -o div_perf div_perf.c -DMULDIV_OPT=0xc3 -m32 && sudo ./div_perf
> 0: ok   336   131   104   104   102   102   103   103   103   105 mul_u64_u64_div_u64_new b*7/3 = 19
> 1: ok   195   195   171   171   171   171   171   171   171   171 mul_u64_u64_div_u64_new ffff0000*ffff0000/f = 1110eeef00000000
> 2: ok   165   162   162   162   162   162   162   162   162   162 mul_u64_u64_div_u64_new ffffffff*ffffffff/1 = fffffffe00000001
> 3: ok   165   173   173   173   173   173   173   173   173   173 mul_u64_u64_div_u64_new ffffffff*ffffffff/2 = 7fffffff00000000
> 4: ok   220   216   202   206   202   206   202   206   202   206 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/2 = fffffffe80000000
> 5: ok   203   205   208   205   209   205   209   205   209   205 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/3 = aaaaaaa9aaaaaaab
> 6: ok   203   203   199   203   199   203   199   203   199   203 mul_u64_u64_div_u64_new 1ffffffff*1ffffffff/4 = ffffffff00000000
> 7: ok   574   421   251   242   246   254   246   254   246   254 mul_u64_u64_div_u64_new ffff000000000000*ffff000000000000/ffff000000000001 = fffeffffffffffff
> 8: ok   370   317   263   262   254   259   258   262   254   259 mul_u64_u64_div_u64_new 3333333333333333*3333333333333333/5555555555555555 = 1eb851eb851eb851
> 9: ok   214   199   177   177   177   177   177   177   177   177 mul_u64_u64_div_u64_new 7fffffffffffffff*2/3 = 5555555555555554
> 10: ok   163   150   128   129   129   129   129   129   129   129 mul_u64_u64_div_u64_new ffffffffffffffff*2/8000000000000000 = 3
> 11: ok   135   133   135   135   135   135   135   135   135   135 mul_u64_u64_div_u64_new ffffffffffffffff*2/c000000000000000 = 2
> 12: ok   206   208   208   180   183   183   183   183   183   183 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000004/8000000000000000 = 8000000000000007
> 13: ok   205   183   183   184   183   183   183   183   183   183 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000001/8000000000000000 = 8000000000000001
> 14: ok   331   296   238   229   232   232   232   232   232   232 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/ffffffffffffffff = 8000000000000001
> 15: ok   324   311   238   239   239   239   239   239   239   242 mul_u64_u64_div_u64_new fffffffffffffffe*8000000000000001/ffffffffffffffff = 8000000000000000
> 16: ok   300   262   265   233   238   234   238   234   238   234 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffe = 8000000000000001
> 17: ok   295   282   244   244   244   244   244   244   244   244 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffd = 8000000000000002
> 18: ok   245   247   235   222   221   222   219   222   221   222 mul_u64_u64_div_u64_new 7fffffffffffffff*ffffffffffffffff/c000000000000000 = aaaaaaaaaaaaaaa8
> 19: ok   235   221   222   221   222   219   222   221   222   219 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/a000000000000000 = ccccccccccccccca
> 20: ok   220   222   221   222   219   222   219   222   221   222 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/9000000000000000 = e38e38e38e38e38b
> 21: ok   225   221   222   219   221   219   221   219   221   219 mul_u64_u64_div_u64_new 7fffffffffffffff*7fffffffffffffff/5000000000000000 = ccccccccccccccc9
> 22: ok   309   274   250   238   237   244   239   241   237   244 mul_u64_u64_div_u64_new ffffffffffffffff*fffffffffffffffe/ffffffffffffffff = fffffffffffffffe
> 23: ok   284   284   250   247   243   247   247   243   247   247 mul_u64_u64_div_u64_new e6102d256d7ea3ae*70a77d0be4c31201/d63ec35ab3220357 = 78f8bf8cc86c6e18
> 24: ok   239   239   243   240   239   239   239   239   239   239 mul_u64_u64_div_u64_new f53bae05cb86c6e1*3847b32d2f8d32e0/cfd4f55a647f403c = 42687f79d8998d35
> 25: ok   255   255   255   255   247   243   247   247   243   247 mul_u64_u64_div_u64_new 9951c5498f941092*1f8c8bfdf287a251/a3c8dc5f81ea3fe2 = 1d887cb25900091f
> 26: ok   327   274   240   242   240   242   240   242   240   242 mul_u64_u64_div_u64_new 374fee9daa1bb2bb*d0bfbff7b8ae3ef/c169337bd42d5179 = 3bb2dbaffcbb961
> 27: ok   461   313   340   259   257   259   257   259   257   259 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
> 28: ok   291   219   180   174   170   173   171   174   171   174 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/d63ec35ab3220357 = 1a599d6e
> 29: ok   280   319   258   257   259   257   259   257   259   257 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
> 30: ok   379   352   247   239   220   225   225   229   228   229 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/63ec35ab3220357 = 387f55cef
> 31: ok   235   219   221   219   221   219   221   219   221   219 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb000000000000 = dc5f7e8b334db07d
> 32: ok   305   263   257   257   258   258   263   257   257   257 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
> 
> $ cc -O2 -o div_perf div_perf.c -DMULDIV_OPT=0x03 -m32 && sudo ./div_perf
> 0: ok   292   127   129   125   123   128   125   123   125   121 mul_u64_u64_div_u64_new b*7/3 = 19
> 1: ok   190   196   151   149   151   149   151   149   151   149 mul_u64_u64_div_u64_new ffff0000*ffff0000/f = 1110eeef00000000
> 2: ok   141   139   139   139   139   139   139   139   139   139 mul_u64_u64_div_u64_new ffffffff*ffffffff/1 = fffffffe00000001
> 3: ok   152   149   151   149   151   149   151   149   151   149 mul_u64_u64_div_u64_new ffffffff*ffffffff/2 = 7fffffff00000000
> 4: ok   667   453   276   270   271   271   271   267   274   272 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/2 = fffffffe80000000
> 5: ok   366   319   373   337   278   278   278   278   278   278 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/3 = aaaaaaa9aaaaaaab
> 6: ok   380   349   268   268   271   265   265   265   265   265 mul_u64_u64_div_u64_new 1ffffffff*1ffffffff/4 = ffffffff00000000
> 7: ok   340   277   255   251   249   255   251   249   255   251 mul_u64_u64_div_u64_new ffff000000000000*ffff000000000000/ffff000000000001 = fffeffffffffffff
> 8: ok   377   302   253   252   256   256   256   256   256   256 mul_u64_u64_div_u64_new 3333333333333333*3333333333333333/5555555555555555 = 1eb851eb851eb851
> 9: ok   181   184   157   155   157   155   157   155   157   155 mul_u64_u64_div_u64_new 7fffffffffffffff*2/3 = 5555555555555554
> 10: ok   304   223   142   139   139   141   139   139   139   139 mul_u64_u64_div_u64_new ffffffffffffffff*2/8000000000000000 = 3
> 11: ok   153   143   148   142   143   142   143   142   143   142 mul_u64_u64_div_u64_new ffffffffffffffff*2/c000000000000000 = 2
> 12: ok   428   323   292   246   257   248   253   250   248   253 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000004/8000000000000000 = 8000000000000007
> 13: ok   289   256   260   257   255   257   255   257   255   257 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000001/8000000000000000 = 8000000000000001
> 14: ok   334   246   234   234   227   233   229   233   229   233 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/ffffffffffffffff = 8000000000000001
> 15: ok   324   302   273   236   236   236   236   236   236   236 mul_u64_u64_div_u64_new fffffffffffffffe*8000000000000001/ffffffffffffffff = 8000000000000000
> 16: ok   269   328   285   259   232   230   236   232   232   236 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffe = 8000000000000001
> 17: ok   307   329   330   244   247   246   245   245   245   245 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffd = 8000000000000002
> 18: ok   359   361   324   258   258   258   258   258   258   258 mul_u64_u64_div_u64_new 7fffffffffffffff*ffffffffffffffff/c000000000000000 = aaaaaaaaaaaaaaa8
> 19: ok   347   325   295   258   260   253   251   251   251   251 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/a000000000000000 = ccccccccccccccca
> 20: ok   339   312   261   260   255   255   255   255   255   255 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/9000000000000000 = e38e38e38e38e38b
> 21: ok   411   349   333   276   272   272   272   272   272   272 mul_u64_u64_div_u64_new 7fffffffffffffff*7fffffffffffffff/5000000000000000 = ccccccccccccccc9
> 22: ok   297   330   290   266   239   236   238   237   238   237 mul_u64_u64_div_u64_new ffffffffffffffff*fffffffffffffffe/ffffffffffffffff = fffffffffffffffe
> 23: ok   299   311   250   247   250   245   247   250   245   247 mul_u64_u64_div_u64_new e6102d256d7ea3ae*70a77d0be4c31201/d63ec35ab3220357 = 78f8bf8cc86c6e18
> 24: ok   274   245   238   237   237   237   237   237   237   247 mul_u64_u64_div_u64_new f53bae05cb86c6e1*3847b32d2f8d32e0/cfd4f55a647f403c = 42687f79d8998d35
> 25: ok   247   247   245   247   250   245   247   250   245   247 mul_u64_u64_div_u64_new 9951c5498f941092*1f8c8bfdf287a251/a3c8dc5f81ea3fe2 = 1d887cb25900091f
> 26: ok   341   354   288   239   242   240   239   242   240   239 mul_u64_u64_div_u64_new 374fee9daa1bb2bb*d0bfbff7b8ae3ef/c169337bd42d5179 = 3bb2dbaffcbb961
> 27: ok   408   375   288   312   257   260   259   259   259   259 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
> 28: ok   289   259   199   198   201   170   170   174   173   173 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/d63ec35ab3220357 = 1a599d6e
> 29: ok   334   257   260   257   260   259   259   259   259   259 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
> 30: ok   341   267   244   233   229   233   229   233   229   233 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/63ec35ab3220357 = 387f55cef
> 31: ok   323   323   297   297   264   268   267   268   267   268 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb000000000000 = dc5f7e8b334db07d
> 32: ok   284   262   251   251   253   251   251   251   251   251 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
> 
> $ cc -O2 -o div_perf div_perf.c -DMULDIV_OPT=0x24 -m32 && sudo ./div_perf
> 0: ok   362   127   125   122   123   122   125   129   126   126 mul_u64_u64_div_u64_new b*7/3 = 19
> 1: ok   190   175   149   150   154   150   154   150   154   150 mul_u64_u64_div_u64_new ffff0000*ffff0000/f = 1110eeef00000000
> 2: ok   144   139   139   139   139   139   139   139   139   139 mul_u64_u64_div_u64_new ffffffff*ffffffff/1 = fffffffe00000001
> 3: ok   146   150   154   154   150   154   150   154   150   154 mul_u64_u64_div_u64_new ffffffff*ffffffff/2 = 7fffffff00000000
> 4: ok   747   554   319   318   316   319   318   328   314   324 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/2 = fffffffe80000000
> 5: ok   426   315   312   315   315   315   315   315   315   315 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/3 = aaaaaaa9aaaaaaab
> 6: ok   352   391   317   316   323   327   323   327   323   324 mul_u64_u64_div_u64_new 1ffffffff*1ffffffff/4 = ffffffff00000000
> 7: ok   369   328   298   292   298   292   298   292   298   292 mul_u64_u64_div_u64_new ffff000000000000*ffff000000000000/ffff000000000001 = fffeffffffffffff
> 8: ok   436   348   298   299   298   300   307   297   297   301 mul_u64_u64_div_u64_new 3333333333333333*3333333333333333/5555555555555555 = 1eb851eb851eb851
> 9: ok   180   183   151   151   151   151   151   151   151   153 mul_u64_u64_div_u64_new 7fffffffffffffff*2/3 = 5555555555555554
> 10: ok   286   251   188   169   174   170   178   170   178   170 mul_u64_u64_div_u64_new ffffffffffffffff*2/8000000000000000 = 3
> 11: ok   230   177   172   177   172   177   172   177   172   177 mul_u64_u64_div_u64_new ffffffffffffffff*2/c000000000000000 = 2
> 12: ok   494   412   371   331   296   298   305   290   296   298 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000004/8000000000000000 = 8000000000000007
> 13: ok   330   300   304   305   290   305   294   302   290   296 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000001/8000000000000000 = 8000000000000001
> 14: ok   284   241   175   172   176   175   175   172   176   175 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/ffffffffffffffff = 8000000000000001
> 15: ok   283   263   171   176   175   175   175   175   175   175 mul_u64_u64_div_u64_new fffffffffffffffe*8000000000000001/ffffffffffffffff = 8000000000000000
> 16: ok   346   247   258   208   202   205   208   202   205   208 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffe = 8000000000000001
> 17: ok   242   272   208   213   209   213   209   213   209   213 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffd = 8000000000000002
> 18: ok   494   337   306   309   309   309   309   309   309   309 mul_u64_u64_div_u64_new 7fffffffffffffff*ffffffffffffffff/c000000000000000 = aaaaaaaaaaaaaaa8
> 19: ok   392   394   329   305   299   302   294   302   292   305 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/a000000000000000 = ccccccccccccccca
> 20: ok   372   307   306   310   308   310   308   310   308   310 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/9000000000000000 = e38e38e38e38e38b
> 21: ok   525   388   310   320   314   313   314   315   312   315 mul_u64_u64_div_u64_new 7fffffffffffffff*7fffffffffffffff/5000000000000000 = ccccccccccccccc9
> 22: ok   400   293   289   354   284   283   284   284   284   284 mul_u64_u64_div_u64_new ffffffffffffffff*fffffffffffffffe/ffffffffffffffff = fffffffffffffffe
> 23: ok   320   324   289   290   289   289   290   289   289   290 mul_u64_u64_div_u64_new e6102d256d7ea3ae*70a77d0be4c31201/d63ec35ab3220357 = 78f8bf8cc86c6e18
> 24: ok   279   289   290   285   285   285   285   285   285   285 mul_u64_u64_div_u64_new f53bae05cb86c6e1*3847b32d2f8d32e0/cfd4f55a647f403c = 42687f79d8998d35
> 25: ok   288   290   289   289   290   289   289   290   289   289 mul_u64_u64_div_u64_new 9951c5498f941092*1f8c8bfdf287a251/a3c8dc5f81ea3fe2 = 1d887cb25900091f
> 26: ok   361   372   351   325   288   293   286   293   294   293 mul_u64_u64_div_u64_new 374fee9daa1bb2bb*d0bfbff7b8ae3ef/c169337bd42d5179 = 3bb2dbaffcbb961
> 27: ok   483   349   302   302   305   300   307   304   307   304 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
> 28: ok   339   328   234   233   213   214   213   208   215   208 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/d63ec35ab3220357 = 1a599d6e
> 29: ok   406   300   303   300   307   304   307   304   307   304 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
> 30: ok   404   421   335   268   265   271   267   271   267   272 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/63ec35ab3220357 = 387f55cef
> 31: ok   484   350   310   309   306   309   309   306   309   309 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb000000000000 = dc5f7e8b334db07d
> 32: ok   368   306   301   307   304   307   304   307   304   307 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
> 
> 	David

# old code x86 32bit
$ cc -O2 -o div_perf div_perf.c -DMULDIV_OPT=0x03 -m32 && sudo ./div_perf
0: ok   450   149   114   114   113   115   119   114   114   115 mul_u64_u64_div_u64 b*7/3 = 19
1: ok   169   166   141   136   140   136   140   136   140   136 mul_u64_u64_div_u64 ffff0000*ffff0000/f = 1110eeef00000000
2: ok   136   136   133   134   130   134   130   134   130   134 mul_u64_u64_div_u64 ffffffff*ffffffff/1 = fffffffe00000001
3: ok   139   138   140   136   140   136   140   136   138   136 mul_u64_u64_div_u64 ffffffff*ffffffff/2 = 7fffffff00000000
4: ok   258   245   161   159   161   159   161   159   161   159 mul_u64_u64_div_u64 1ffffffff*ffffffff/2 = fffffffe80000000
5: ok  1806  1474  1210  1148  1204  1146  1147  1149  1147  1149 mul_u64_u64_div_u64 1ffffffff*ffffffff/3 = aaaaaaa9aaaaaaab
6: ok   243   192   192   161   162   162   162   162   162   162 mul_u64_u64_div_u64 1ffffffff*1ffffffff/4 = ffffffff00000000
7: ok   965   907   902   833   835   842   858   846   806   805 mul_u64_u64_div_u64 ffff000000000000*ffff000000000000/ffff000000000001 = fffeffffffffffff
8: ok  1171   962   860   922   860   860   860   860   860   860 mul_u64_u64_div_u64 3333333333333333*3333333333333333/5555555555555555 = 1eb851eb851eb851
9: ok   169   176   147   146   142   146   142   146   141   146 mul_u64_u64_div_u64 7fffffffffffffff*2/3 = 5555555555555554
10: ok   205   198   142   136   141   139   141   139   141   139 mul_u64_u64_div_u64 ffffffffffffffff*2/8000000000000000 = 3
11: ok   145   143   143   143   143   143   143   144   143   144 mul_u64_u64_div_u64 ffffffffffffffff*2/c000000000000000 = 2
12: ok   186   188   188   163   161   163   161   163   161   163 mul_u64_u64_div_u64 ffffffffffffffff*4000000000000004/8000000000000000 = 8000000000000007
13: ok   158   160   156   156   156   156   156   156   156   156 mul_u64_u64_div_u64 ffffffffffffffff*4000000000000001/8000000000000000 = 8000000000000001
14: ok   271   261   166   139   138   138   138   138   138   138 mul_u64_u64_div_u64 ffffffffffffffff*8000000000000001/ffffffffffffffff = 8000000000000001
15: ok   242   190   170   171   155   127   124   125   124   125 mul_u64_u64_div_u64 fffffffffffffffe*8000000000000001/ffffffffffffffff = 8000000000000000
16: ok   210   175   176   176   215   146   149   148   149   149 mul_u64_u64_div_u64 ffffffffffffffff*8000000000000001/fffffffffffffffe = 8000000000000001
17: ok   235   224   188   139   140   136   139   140   136   139 mul_u64_u64_div_u64 ffffffffffffffff*8000000000000001/fffffffffffffffd = 8000000000000002
18: ok  1124  1035   960   960   960   960   960   960   960   960 mul_u64_u64_div_u64 7fffffffffffffff*ffffffffffffffff/c000000000000000 = aaaaaaaaaaaaaaa8
19: ok  1106  1092  1028  1027  1010  1009  1011  1010  1010  1010 mul_u64_u64_div_u64 ffffffffffffffff*7fffffffffffffff/a000000000000000 = ccccccccccccccca
20: ok  1123  1015  1017  1017  1003  1002  1002  1002  1002  1002 mul_u64_u64_div_u64 ffffffffffffffff*7fffffffffffffff/9000000000000000 = e38e38e38e38e38b
21: ok   997   973   974   975   974   975   974   975   974   975 mul_u64_u64_div_u64 7fffffffffffffff*7fffffffffffffff/5000000000000000 = ccccccccccccccc9
22: ok   892   834   808   802   832   786   780   784   783   773 mul_u64_u64_div_u64 ffffffffffffffff*fffffffffffffffe/ffffffffffffffff = fffffffffffffffe
23: ok  1495  1162  1028   896   898   898   898   898   898   898 mul_u64_u64_div_u64 e6102d256d7ea3ae*70a77d0be4c31201/d63ec35ab3220357 = 78f8bf8cc86c6e18
24: ok  1493  1220   962   880   880   880   880   880   880   880 mul_u64_u64_div_u64 f53bae05cb86c6e1*3847b32d2f8d32e0/cfd4f55a647f403c = 42687f79d8998d35
25: ok  1079   960   830   709   711   708   708   708   708   708 mul_u64_u64_div_u64 9951c5498f941092*1f8c8bfdf287a251/a3c8dc5f81ea3fe2 = 1d887cb25900091f
26: ok  1551  1257  1043   956   957   957   957   957   957   957 mul_u64_u64_div_u64 374fee9daa1bb2bb*d0bfbff7b8ae3ef/c169337bd42d5179 = 3bb2dbaffcbb961
27: ok  1473  1193   995   995   995   995   995   995   995   995 mul_u64_u64_div_u64 eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
28: ok   797   735   579   535   533   534   534   534   534   534 mul_u64_u64_div_u64 2d256d7ea3ae*7d0be4c31201/d63ec35ab3220357 = 1a599d6e
29: ok  1122   993   995   995   995   995   995   995   995   995 mul_u64_u64_div_u64 eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
30: ok   931   789   674   604   605   606   605   606   605   606 mul_u64_u64_div_u64 2d256d7ea3ae*7d0be4c31201/63ec35ab3220357 = 387f55cef
31: ok  1536  1247  1068  1034  1034  1034  1034  1094  1032  1035 mul_u64_u64_div_u64 eac0d03ac10eeaf0*89be05dfa162ed9b/92bb000000000000 = dc5f7e8b334db07d
32: ok  1068  1019   995   995   995   995   995   995   995   995 mul_u64_u64_div_u64 eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216

	David

