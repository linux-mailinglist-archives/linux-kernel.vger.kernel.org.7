Return-Path: <linux-kernel+bounces-776673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CEDB2D04A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281461C4347D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778942749D2;
	Tue, 19 Aug 2025 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mghclKfy"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB22721885A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755647057; cv=none; b=k2V3mNlr17UDszj8NLYHp65hEe8p41kbaaMMInej/ALa8YJ3sWqyzwaTiEPKWC3NMSDG2SfRsHC1UTzQkAsGOnRCrypkQNMsdiSQEvfsf0rbyPljZnDimmnNwND4MQKH3ihe/oGlHUEY+48RmBzBxh/NQ0+l/fXKafaToPTJX8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755647057; c=relaxed/simple;
	bh=AXqdM+Q0eFpoS6vnlCrXfj+VF2rRgtWLAeoGvwHql/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hl/lWA6bcTpUpsKKjowd/hjY/ScKUohApnCimRUIUMgOE6kT9XEoA729hTdFfP+kvYmMGML0pKxNLnX4+pQ486rGMooI+Yn+8Lnjn2XXLiVANYQnQhgiIMRkqhPzINUp0fJJJoOjnWtA5kqJvyj7q/1p+sGYD0eE0lBlqnz1m00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mghclKfy; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b0bf04716aso74781cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755647052; x=1756251852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8TLK/jOyX6EtWsZK6GK1tYBP22fcct/haUDBf8qxbFQ=;
        b=mghclKfy9CSkmvvAvTA6FlIAggwlclFit5WplEZNtlmQ5dGAi+pz/csQ155HLJrZ5+
         kKP85I+cLAn0l/R9JKLEkajqdLG5xZjXyykbVzg1gcQHrdw64DLyU7uC8MMXt2kA26cB
         95mAc60g95KJJZzO9b6eho5GMq6f2mFwusXF6GZHxyT1RE1BGi/cfG1kN3GTYrgDCUST
         HpnXXzP8xY2vzMuRDvN6gpwFcFJ9SRLbbcUaGDArwY8luikgg2ZNdZTj7rVssjC8kw7b
         XnqH36t+iEYMfUV1szqYP+cVrQi67SuTYbhIJsCSO8/31u89/hPIJJI7YeStS2RjqMNo
         ZpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755647052; x=1756251852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TLK/jOyX6EtWsZK6GK1tYBP22fcct/haUDBf8qxbFQ=;
        b=i8M5jHcvMqhzJHB9lHs2NvHRD5i+scCRYmy5k7RX6HLkPciEsY7Fqq+WgHoVoh6C4g
         YQYXWj90+t4TGbnY/aYORmbvP9Nx+LnY1Pxto8D0Hy8UYjVB2c/WE3oAmnMwCVGQwc8z
         4PKkdu8Jxln53Z2tubmvXg1fEe57RRd309H5loiGiYL4amU9Jc+YQXfaL0GO/YUlJ1rl
         a2If3rIQ+AsODuFlnIRPQ7UA6Gie+Vg5+d/teA7m55fOau0H3nd0agNroxbQbxSMgir6
         JCshdisDhWMsJ6QXqVAQDydDJA6sedimzd8aqdpZZnfaecloTrOx0rUHHJa+cvEYagoy
         8zTw==
X-Forwarded-Encrypted: i=1; AJvYcCUDiBNYJsE0PtndDNNDKeRSod7mxuAfY1NdfsA5EbwjuUotT5z9lNnrUExNkn7g7dY3G3Crr6kLNKKARlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZKezWHcKs36qg6iPs6h8kk484x4D/8qdfnFnzHlZ3ySTuRHJC
	3qX17Hju6ntFshcg7NFyPFi8P0Bu0jNwM/j3msV6StXMgXUzskHAO6Cyy87TYCEwKvijixL9Xje
	qNaC5sdUJfsg2qesjD2qBzI4tlw33f+q2yj/Uxb8y
X-Gm-Gg: ASbGncsiyYjiHDnRyq2OhTbuxbpD4+Q/FoT4HLs6t7YRAm/b1LfTzefmjsH/bkhaOxu
	0Wop5esW10sT/SfxVZJD5zrHqSG557h1PITrKjOtp9z8wD/b/TEI8CEYKwyDJB45cg0sHJ6FxY9
	CFW7yWtKpErWLDo2TBmviyM5u+s9lIIi7AxJZvPBgqJok1qfv0rQBPrP0/9UEd6aBRMrFUcZMv3
	ZxBsIxRbOQp
X-Google-Smtp-Source: AGHT+IGDEvrAr6Lkde7u29HdZI4XDLsBV/2FzapCrmOWC2je0bl/DZcv3Rx2QUDFSuzNLP8gDCL8RQmeFD5PN1leSiI=
X-Received: by 2002:a05:622a:30f:b0:4a9:e17a:6288 with SMTP id
 d75a77b69052e-4b292fc3b7emr1196511cf.13.1755647051405; Tue, 19 Aug 2025
 16:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730220812.53098-1-pmalani@google.com> <8252b1e6-5d13-4f26-8aa3-30e841639e10@os.amperecomputing.com>
 <CAFivqmKZcipdc1P1b7jkNTBAV-WE4bSeW8z=eHHmtHBxuErZiQ@mail.gmail.com> <aKRDxhirzwEPxaqd@arm.com>
In-Reply-To: <aKRDxhirzwEPxaqd@arm.com>
From: Prashant Malani <pmalani@google.com>
Date: Tue, 19 Aug 2025 16:43:59 -0700
X-Gm-Features: Ac12FXz28B8pNg1mWH2v21OiJB-uG4u0PrV_qopcNcwtRp9H3Jb0cDlYPYisjpQ
Message-ID: <CAFivqm+vzkbDEadJEF2So9ZWcRyVT_-Yc+8VWWwsgGW+KD4sNw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: CPPC: Increase delay between perf counter reads
To: Beata Michalska <beata.michalska@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Ionela Voinescu <Ionela.Voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Aug 2025 at 02:29, Beata Michalska <beata.michalska@arm.com> wrote:
>
> On Tue, Aug 05, 2025 at 06:00:09PM -0700, Prashant Malani wrote:
> > Thanks Yang,
> >
> > On Tue, 5 Aug 2025 at 17:26, Yang Shi <yang@os.amperecomputing.com> wrote:
> > > Thank you for cc'ing me the patch. I posted the similar patch ago and
> > > had some discussion on the mailing list. Then someone else from ARM
> > > pursued a different way to solve it. But I didn't follow very closely.
> > > If I remember correctly, a new sysfs interface, called cpuinfo_avg_freq
> > > was added. It should be the preferred way to get cpu frequency. Please
> > > see
> > > https://github.com/torvalds/linux/commit/fbb4a4759b541d09ebb8e391d5fa7f9a5a0cad61.
> > >
> > > Added Beata Michalska in the loop too, who is the author of the patch.
> > > Please feel free to correct me, if I'm wrong.
> >
> > Thanks for the additional context. Yeah, the issue is that :
> > - The new sysfs node is sampling period is too long (20ms) [1]
> > That makes it problematic for userspace use cases, so we need something
> > which takes less time.
> That actually specifies the duration, for which the most recently acquired
> sample is considered valid. Sampling is tick-based.

Thanks for the correction. I made an error in understanding the code.

>
> > - The central accuracy issue behind cpuinfo_cur_freq still needs to be handled.
> I'd really discourage increasing the sampling period for cppc.

The only true solution is to make the register reads (ref + delivered
combined) atomic.
We see that this solves the issue when conducting the same
measurements on firmware
(which is an RTOS, so no scheduler randomness).

Outside of that, I can't think of another mitigation beyond adding delay to make
the time deltas not matter so much.

Perhaps ARM should introduce a "snapshot" feature which takes the snapshot
of the AMU counters on a register write; IAC that's outside the scope
of this discussion.

Could you kindly explain why adding the udelay here is discouraged?

Best regards,

-- 
-Prashant

