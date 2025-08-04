Return-Path: <linux-kernel+bounces-755233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CEBB1A355
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FBC189F6A8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F77270EA3;
	Mon,  4 Aug 2025 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="mLbAN61t"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE1026FA7B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314369; cv=none; b=pvU8h67LkMSC+i/gc69umwcaaNtSyroCwxbrIx12HZAgBD4fxUT1/YJ3RuXGXsi2/zDTxtCZ5eCOKIcFfDvm4NVLC51jrdzoFnqRana8fS+zoBr49MXEzu0+vwGVoDJiy9l7tof6NmErssHSDlEM6/+utT1Gn9dGaPctHIy/JZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314369; c=relaxed/simple;
	bh=c2zZubdYruK/gDLxhJT/Dee+/3njse4nUBcteSLRYms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtqYEmvPI8mH8Ga4yRYqZpRZFhsB6/Il1eTsTOosPiWCKeYHcslGkHRVO71/ZD15erH1UGcA8zRJRa2EIIZUWGAtZtcUIFQbnm8wgg13MpysagWB4I32iwXWeV+nyDjj4RrH4PaRTaOa95sXjumwp+zxHZzGW9ZABnRqjCQI198=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=mLbAN61t; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7075bcdbb0fso19683726d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 06:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1754314365; x=1754919165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ARdbuY4ihnBfNqmPKZqv+tAobgDvylQcvqI7MjhLvS8=;
        b=mLbAN61tBdBx+yD+bhy2PU/4TJazTG2zGQ3Z9yzp6T0njtqnM1416UZ7qLVFwm7Du5
         tRAq+O6Hydo/zIt40EUYvR4qwG6yujuxkMRAw4eIBg4vODjibzTK7rZdfPJULF7PBEZx
         NHLCxqo1fBpH77iPiNB8SfrwsABR/bafV1Zly03Tntfr5jWK/lJ1dOzPHcv7ENQ8BS6c
         7FzOHOQ6oG3aU6fg9rEdL/GWxLOTBWlyYYKv9Dy+1JBpttJUWK1dczUiHcJVay3lI+Mc
         YGvaxteuBi/0eDfqs7Y8hMl4NhnfGVyiFnrWBaIh/cTqLrDHh4kuGMmwCSGQp97Jh1KZ
         OlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754314365; x=1754919165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARdbuY4ihnBfNqmPKZqv+tAobgDvylQcvqI7MjhLvS8=;
        b=SbJvxVWBHPzqdUKP/bzHPO4DieeUJdEInEndAuZj/ZNCC6y0PhlIadDbVWn9AVmeEu
         3/FpBo3IqjXLBf2RB/UeXz3S2+JcOdoYvB+3eyknWK2UyknT0G8vdF/wGWufBTUavVPU
         Vi4oDVSGZilK0A1ZLkotqMnBe89MenNOBu8A/Q2546zYjqx1LVQBVeHdWMlYrHOj7nXi
         bmoaS5eId9GQIGfbx8bLq5UyyA4roQnMOjAJwGlCR4THEc1ytEkzSH+qbVwqU6ZlhRPr
         J1MbjMRbo7fF9Om1puZAnx4DOPa734fyYEtY4nhauCHp7BXr7Po2UykumxnYtMAxjwBy
         NgHQ==
X-Gm-Message-State: AOJu0YxQ1ZAftbXKIM1EL1bw8xVb2+NdKkpS5firsdUMJpBPy97yEs0q
	cXINHcujNJk1w509ngd8RTSZHCP5dwSAi5S+oZfllcuFKPbCsZTo1TkVZ8868qEzei8=
X-Gm-Gg: ASbGncumnsHkrpF9d649JCgKziD6BYFlKFE5CKX489C3Ppirrj8vDQyMaGTrpdMZVaB
	IfbW/Qq8fdvzYdipWFImLIwZ7DGtXrIZ4Cf0boHoBDsDP5yGnoUwbejHMNDf8BZsLvvsGGB9GHf
	/0eiwdi6/WAnCqSZ9IWPZrBA2AsQRcKXi8dwCW4b7D57zgxNZ2jc+F9VDMjxX1SR2NmP/Zs8LIz
	JkZzrmxrxkvxOwurj3u3kQXPX+QV6+98v2mpbAbQdtA0/fzZTJy2UX/8tNPZGUVMLyzhoFZHPJR
	Z1DdlyF3gkfIBfTFUcM9xYWBILpuqzfhxqYVLPB0UToiAUlGQRnBZA2u6LfrZQo42I3DNl0HEng
	blZvG3oeTEuvwzSgcYozSHg==
X-Google-Smtp-Source: AGHT+IF7J9OrujvHAgN5i0H7oCNZ6uBRyDC1EFC/YvErPRsiTQSvUU17oBWdAHJzGy7XoL/W1tODjA==
X-Received: by 2002:a05:6214:4015:b0:707:77cb:5b0b with SMTP id 6a1803df08f44-70936243ecemr127645756d6.26.1754314364892;
        Mon, 04 Aug 2025 06:32:44 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7077cde6062sm58097776d6.71.2025.08.04.06.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 06:32:44 -0700 (PDT)
Date: Mon, 4 Aug 2025 09:32:40 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: linux-kernel@vger.kernel.org, surenb@google.com, bsegall@google.com,
	dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
	mgorman@suse.de, peterz@infradead.org, rostedt@goodmis.org,
	vschneid@redhat.com, vincent.guittot@linaro.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] intermittent psi_avgs_work soft lockup
Message-ID: <20250804133240.GA1303466@cmpxchg.org>
References: <aI_fUhpBrIBrJ073@debian.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aI_fUhpBrIBrJ073@debian.local>

Hi Chris,

On Sun, Aug 03, 2025 at 11:14:42PM +0100, Chris Bainbridge wrote:
> Hello,
> 
> I'm getting intermittent soft lockups with recent kernel builds. This is
> a new error that I haven't seen before.

This smells of the seqlock re-init problem in 570c8efd5eb7. Could you
try to see if the below patch fixes it for you?

https://lore.kernel.org/lkml/20250716104050.GR1613200@noisy.programming.kicks-ass.net/

We probably want Cc: stable on this patch now that 6.16 is released.

Thanks

