Return-Path: <linux-kernel+bounces-764793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAA2B22765
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0413507896
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEBC270ED7;
	Tue, 12 Aug 2025 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4Lr9HYm"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D003A25949A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003025; cv=none; b=cNhYCyuM6GNZD0QpJJj6x+U/X5b0880emMinWNFB76S4ZhBDEoPZMHm5lNJZzqVEo6qQJNNttm5/1+53po9vPwmom5mxJs7/5O/yuIUQmTUjzbeUJIisupikpGH7xGn7h2aBINDRZ0mpVwboLFu3L4sGFkEI9vN+rZS4RXOv2MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003025; c=relaxed/simple;
	bh=n2W5lBhQWtEfcIq0If1byz5cGgSOoZbaxeVFx8BtvR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rn7IZOPLOyXySJ2FIyWEmGZzHdZw80DXqI7YQYq7tWzFO1t14JegaDbvSEpzvPilnY9ENtvUt2gDjh/CEYkVqOl9t1ekJ4Wf41YY3R3iPl2LMxJ5E8LjNYIppyUIw5Et27e+uy01y/Bgdp7FbKYpJyvyI2I2bo38ShzUmASm600=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4Lr9HYm; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71cb6973d61so5458177b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755003023; x=1755607823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vb56kCsZ8TkPxx/6TDsiLo0rbjuubigrK78dygoytVE=;
        b=S4Lr9HYmUUcIjrkYm14T9HDbYDLK72vX9b0BZ652uAW8VAnJl3LxQxd2msa8a4ZXTb
         fVsbi9USXzstQyEJ09sxTtZayBz9M0Lhr0erHcDcTMsMi64T+NTwQwWOJyhkj/WC/SM2
         hcqHpjPI6rTGvPHkoTwCZRq0GravOlslmmhAN1W4/HgQ1fDBnC752sO7+dNjE70Nh8SL
         H1WV/vB5uH7h3rd2Cwai4jkq29sdQauUdyY+KMJZMoKYRw7zASz2bs/nG/qklqHf8HXL
         SGxdOTgikN3UKXl7tgKWENmuZEPp+zdmkvGJLhIn/eetuFscJxkyrS/jt2se733GzsTM
         FTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003023; x=1755607823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vb56kCsZ8TkPxx/6TDsiLo0rbjuubigrK78dygoytVE=;
        b=tGzRYo6ILygPjXrvfx73l77dqnPbTd/08SXqhFFY/6B34JXtMk7/hxFX+AGYdfkqZe
         ze2PeAaJ72qWNOJQ7GWVXD8f+5gq3d60uH/wQSSuM/SmCIxoOECRcOvMr+1zFBSRkSi7
         CsrsK6aG1ySDxQRLfC0uswYo9tuuMEDJVHYSZQXT1PhXpRilWwdThziRFriGUzxY6xTM
         7+bAnOAoQ3Tp7G6Ufs28/Qa6oFd5MMEHQMnTeHVq/hs2V27DmceTqKJrnA9M0qSFLCqP
         QKVcWDZWJGFhKJ8tM5losgZkaFi4E4GswQng40p4JMFPWYEVMchBQYGAhxYbTO7YqHYX
         F3Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVzoGY6/pi7GN7h9SCk415DG7DToapv7d+MnmZbm7mwpthS9ay4xdHtfIFgPToE2v8CV4xKqJLormlmYj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZRiBcK3m3L7t8+cz6L+Mn6W13ZZDLGdB8nmsq0rV1fqmpfZTi
	MnkcgDxom+3ObYO95VF6TPPj4eshPSsK7p1YB2yzHA1U9xxllkMx6aqZ
X-Gm-Gg: ASbGnctbyC6Z3UzCnuTeQPsp/VCvjfNfyHtGgQ39JHytvtD7FOekjepPHIWTcfZSA3y
	jIft1KhDEgZ26bWlj9MqRM28t4VioIbzKXXpGx6nYSBDz1dXalrlBh6pxQIrI4m4HQpiEUrD3ZB
	H+Ek15cDXTKPPNWdI9Qurg0N9Pa3M1eQ3zfs9dmfH/A9ceVMDwviiffY+GGzhgdHJCxo4p8C85q
	2/bM6qPl7lMs47CcICeF+dPjkRTEBaGn5ANM6jodb19lBCbfP2NWoE9xrK0dMMy0NRBcwuKxHzv
	RpKJRqHmaauqwpergtImHUWHw8/fC5niLaMLwLwEgHlEmD9u+JjosFEuQ08rEXf/oYgKNvsJTcy
	QGDolMAe0ckjUYYj7rWd2
X-Google-Smtp-Source: AGHT+IH9z4DjLJuZHM4mI+w7INSF2JZBNie5JI9pkU0VchWfLroDX8ZTeWpdBB4k0Ch2Ih8kZnZL3A==
X-Received: by 2002:a05:690c:4d86:b0:71a:1c70:c221 with SMTP id 00721157ae682-71c42f15810mr35909667b3.15.1755003022627;
        Tue, 12 Aug 2025 05:50:22 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71bcf6a7be2sm39783697b3.0.2025.08.12.05.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:50:22 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/numa_memblks: Use pr_debug instead of printk(KERN_DEBUG)
Date: Tue, 12 Aug 2025 05:50:19 -0700
Message-ID: <20250812125020.2136635-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALzOmR1BoVs4LGaygpE-fiKsRztCh4_tsESyFTT5qiHtup5E7w@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 12 Aug 2025 08:43:48 +0530 Pratyush Brahma <pratyush.brahma@oss.qualcomm.com> wrote:

> On Mon, Aug 11, 2025 at 7:33 PM Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> >
> > On Mon, 11 Aug 2025 11:01:32 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> >
> > > On Mon, Aug 11, 2025 at 12:13:54PM +0530, pratyush.brahma@oss.qualcomm.com wrote:
> > > > From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> > > >
> > > > Replace the direct usage of printk(KERN_DEBUG ...) with pr_debug(...) to
> > > > align with the consistent `pr_*` API usage within the file.
> > > >
> > > > Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > > > Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> > > > ---
> > > > Changes in v2:
> > > > - Removed printk header as suggested by Joshua.
> > > > - Link to v1: https://lore.kernel.org/r/20250808-numa-dbg-v1-1-2ddd1ec634aa@oss.qualcomm.com
> > > > ---
> > > >  mm/numa_memblks.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
> > > > index 541a99c4071a67e5b0ef66f4136dee268a880003..ed6fcfca057ab4c9a8aa26cd1929551b4ded4a5b 100644
> > > > --- a/mm/numa_memblks.c
> > > > +++ b/mm/numa_memblks.c
> > > > @@ -2,7 +2,6 @@
> > > >
> > > >  #include <linux/array_size.h>
> > > >  #include <linux/sort.h>
> > > > -#include <linux/printk.h>
> > >
> > > Please don't, pr_debug is defined there.
> >
> > Hello Mike, you're totally right, sorry about the incorrect feedback.
> > For some reason I completely missed this dependency when reviewing.
> > Joshua
> 
> While the current patch compiles fine as some other header includes printk,
> I see sense in Mike's suggestion to keep the printk header. I'll
> revert to my original patch
> in the next iteration. Joshua, would you be okay with me keeping your R-by tag
> in the original implementation?

Hi Pratyush, 

Yes, for sure. I think in general include-what-you-use is a good rule of thumb,
it was just my mistake that I overlooked pr_debug being defined in
linux/printk as well.

Have a great day, sorry again for the noise.
Joshua

