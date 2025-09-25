Return-Path: <linux-kernel+bounces-832433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D06B9F4DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23724C046D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D5023313E;
	Thu, 25 Sep 2025 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzKo123o"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EC61A76B1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804055; cv=none; b=DlWOOJsL5EgWtED1xreGGQ8fqi4favKqDM0NzdwRinUQP8ijdy3FYAzhkvsMnTCSlJI8GUp5syI1LevdQlurEQpLZ5SZytkM2V1aiB6yERTxLXvCFUtSXzd+LeQg0s2X3ZSLZFCmOPu1vI6MYYp5Z7XxUzUfkZq5hkRXLTpjJO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804055; c=relaxed/simple;
	bh=VXON1v7RvXA7Y4H/9zywjlqD/4OXJyQ9u4H3dPvrN4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsEVlhk2tsEh3xmR9lrEaYcN6uC4iPOLZlYQI3YaxdFPQoBD0vxnkROit3gPoO5Brf5EA+oERRWARdL2regkyd+4CsoWrbWs9s3M0M4VqHYwlerflmWCjDrR9QzV3v1CnFY2gAOQeaBHtSw2clHRAyxc679xZxXr0SMoOGp2zqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzKo123o; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b07e3a77b72so342739466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758804051; x=1759408851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w4iZfEG4kVECR3QGnQozF1ONlvbS7K+/HZuIx+Nym7I=;
        b=mzKo123o4mA17/bqhXtbHWqZBbRW5bi7sjPdCyD40EEOLSaQ31nZeX1S7JfJmEg9Hw
         cZJpnnrTFGZ8o/MEnFiMSnWrBYRwn5Sakn+WjXyKySbF+5DP87a9wkEb6njD5yvmLgiP
         vyZ+SEICL8SHPi9J0WxNUm6yG/9Hnhy9wTd9Z/LPXVxIkryKtemptmaApy1o3Al9M7hi
         50M4ej39G4lMY/Bqi1N8QeHkMzG5Irbi2shA+6Fz/SDiPTPcEyl8N4pPljjwQsu2+DkO
         zaWolASy9P+6Nm3eFW6mtGxIU8PRaT7000FHU7hPVC08pKkphDFvkFS+j+H7rq+ZPO2h
         YSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758804051; x=1759408851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4iZfEG4kVECR3QGnQozF1ONlvbS7K+/HZuIx+Nym7I=;
        b=arrqLQjC9xBCYwKsGGLRAWFpu5jx6NKnlkahZtHtzQBxT8ivI0MYPhb8QdU9Jg2MaQ
         frt6YLPMwtk2NwJyCgen+Vm5B1yk6nYxm//W3eBXDSE/zjcxyBV/UC6TkVNJDSDb0Tul
         ZADn2TiDi+mZGMH3h6tqxj2ofhhwqlHEWTS8SH7b7u+hgPVjvJfFXAAhh4dwng85N1yj
         SMbKBWBebjtS4qPl/eguvj2xeft1ruTUiLAaLGhTUkqlFemA5grMaslF4AxvX5oWNpaZ
         eGt9QS6VoAz20wVHMQByCUVjcZotTieWkWYfeosn5HAVg769ay9aTjXzE8AS9EKPwjzV
         x/Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUPc34uUivPwTe0wTA/pQuhxjTVHeNYj7RVAhEvALhp4CKoVzs+2ihn0oFoymWeJoWeDd1oUg5YsyYUO6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxelEHF48JOx05Vn1JYkeJxPYTwIdHVR4Fzggg9sxCUdu9trvt
	/rphzF3/HwVWrv5giF3MNZeTNIo+tp0zM0l+2wlbYOdTm0MnSLEKAM/y
X-Gm-Gg: ASbGncs411+PrXRYNKu4FmHgzWjPTgOtLJvteEVvITh02BaRhvDy5Ka7VjJlHHuhYsl
	gKIBonn5ap8j0aNXAN7U6R9S37EXB7C7qSJRd8+6iOaWBps4+bCPdASRezTnmSetTUiS8XHqtSR
	3yb0AvBftUAzutPDVpndKm7NtwgBN3db9HtO+8chj4v43+ggn/k2bYwAcrBda06zFyQ1bcoRyvc
	EDSde8g+ZVK/+2WA+Wud4yKn199wsE0IoQP07JsO9ZLqe59KGrIWpKfc+/aVrCCs4qU1wwI2k0A
	1J9j3kqXc+l2MU0m74VyarxzvrhN2L41fH3rgboE7gY1nlsZAb/5QpRy/5vcfLVYdfWVLZZcAFs
	UPr23SUvZ65nYOz9zWX7eS/ZeH+ZbbeX0I5Ix8Cf9qWCS9ms8ZsTHTniEy42Bujcgm00V1Yev
X-Google-Smtp-Source: AGHT+IH1zVng8lk0TycVJy+o3g1mDILGx3FJMUy3vX3S9k2pmy4r7gL8isXWlnXBqQz/KWO9gE7z2w==
X-Received: by 2002:a17:907:1c94:b0:afe:ef8a:a48b with SMTP id a640c23a62f3a-b354e41468amr279935366b.30.1758804050688;
        Thu, 25 Sep 2025 05:40:50 -0700 (PDT)
Received: from alessandro-pc (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3545a98416sm158093566b.102.2025.09.25.05.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 05:40:50 -0700 (PDT)
Date: Thu, 25 Sep 2025 14:40:47 +0200
From: Alessandro Zanni <alessandrozanni.dev@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest: net: Fix error message if empty variable
Message-ID: <ryyvwk64xplpvwozytdsfkyxls7sa3r4p4xpdqfhh6h2k4rdhl@chwwppzuvbop>
References: <20250924230413.75246-1-alessandro.zanni87@gmail.com>
 <20250925104930.GG836419@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925104930.GG836419@horms.kernel.org>

On Thu, Sep 25, 2025 at 11:49:30AM +0100, Simon Horman wrote:
> On Thu, Sep 25, 2025 at 01:04:07AM +0200, Alessandro Zanni wrote:
> > Fix to avoid cases where the `res` shell variable is
> > empty in script comparisons.
> > 
> > The issue can be reproduced with the command:
> > make kselftest TARGETS=net
> > 
> > It solves the error:
> > ./tfo_passive.sh: line 98: [: -eq: unary operator expected
> > 
> > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > ---
> >  tools/testing/selftests/net/tfo_passive.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/net/tfo_passive.sh b/tools/testing/selftests/net/tfo_passive.sh
> > index 80bf11fdc046..2655931b2396 100755
> > --- a/tools/testing/selftests/net/tfo_passive.sh
> > +++ b/tools/testing/selftests/net/tfo_passive.sh
> > @@ -95,7 +95,7 @@ wait
> >  res=$(cat $out_file)
> >  rm $out_file
> >  
> > -if [ $res -eq 0 ]; then
> > +if [ -n "$res" ] && [ $res -eq 0 ]; then
> >  	echo "got invalid NAPI ID from passive TFO socket"
> >  	cleanup_ns
> >  	exit 1
> 
> Hi Alessandro,
> 
> I'm not sure what $res can be in practice.
> But as it is the contents of $out_file (or more specifically,
> the stdout of running cat $outfile), in theory it could be anything.
> 
> So while your patch addresses one error case.
> I think there are others.
> 
> f.e. if res is not empty but not numeric, then we may see
> 
> bash: [: b: integer expression expected
> 
> Or if res contains a newline, then we may see
> 
> bash: [: too many arguments
> 
> 
> So I wonder if it is better to treat $res as a string,
> and quote it to avoid unexpected side effects.
> 
> [ "$res" = "0" ]

I'm not sure about the possible values in $res neither.
I assumed it was numeric because of the "-eq" operator but,
if it can be any value, a string comparison would be better.

I'm going to edit it.

Thanks,
Alessandro

