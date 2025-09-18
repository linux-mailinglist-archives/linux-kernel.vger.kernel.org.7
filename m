Return-Path: <linux-kernel+bounces-821922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93739B829F3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20B74A53E7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42269238142;
	Thu, 18 Sep 2025 02:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="cEjviIj7"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E36235345
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758161450; cv=none; b=kBJOTmSPTFt77cq1WDvELI5nXzEXmyNViZ7yM2DrpvFU3lfNiAA8wODdqT5OnGT1ZGzMHcKGYr2est55mbj1Mi3OiWz1yodLbBsJZ9BpoPojdMBHYq6bcPFpDUmiu5zdNnP6fW6PKt++/KqhuStx1Le4zkxSQ7LiF0Lbc1Wkzf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758161450; c=relaxed/simple;
	bh=aAq3GpDO8dHD59hiZUOgm8+s3e4FokNk1g5m+eFePys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUfFhi73nRZlZZxF5h74hpirS+rpHb/eeSl1RmmYWnnip38febxO9BfdXKobgSdYGVslRM5joIWB/GpJbQnNR8vigW1tVUQb2Dzmn1WoIiIWZFJLeqa7M56O/w9kVE/SqPota8ty6STmmfn00KNrPIfl5o0HlJT0fFZwAkdsomc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=cEjviIj7; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-80e3612e1a7so79646085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1758161447; x=1758766247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Evg9VjC868jXEyq9jooY+5VpA/zgsMZDDv3GTIqYmAI=;
        b=cEjviIj7qoprH/DsL0Y9o4suKQqtNMuY2Yj23/CqSMrBKm4vF+mnGla9HzzaCBult+
         olPr9cgcTRCl1sd60RVsh3a0AmrUfHc8RLz0SIWeRNuz4pmaKs6yRh+Vu9ITm4G/NuWd
         c7vOgiwuJ1wnN33nQ0DCF9p+xCWBvrv4YMyEgoH1TkC2A8hFiRuoGDf2V0lKQxJ2Jn4z
         rKkaPvHBbZMMdGl+1rCi1fWl4kRjm/Y8CpUYF8wuikFHgE4Ja3/i462VydfAGQZ4kVn8
         qO+cOsgPZ338h+R+fpwu5LaFB8HQ7f9UGJp+T8vahQF6U5paW4Zk+HpzFTq0RSizdJ13
         B62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758161447; x=1758766247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Evg9VjC868jXEyq9jooY+5VpA/zgsMZDDv3GTIqYmAI=;
        b=NXUGagAijrsfl5WUy5TnDP0B+yq1Q/QVjkCpHZhMV1mxaw5AUXEZqy6Q0it17Ogr9U
         K1IwLVKmh04S1LijfWTkgENROoOj54vloVZSbHnxPjZCJ2Ky++fWo5f24Oi64fc9nVzZ
         ApE77G0vR24BMPDV2pE3+IykWxmlIaJkz+zneXG+3GEWUxqdPndNh7LMU1tcRSMmKerD
         ghcvpfdt8aLtLa4vHA6jF47Y0XmlVqtHt/zEz5WmfEnDd9DybAQWMzbkxy4dYQ1hfDTK
         /P/7q4/UKbLdidZaOSflp/kXvHqMM6Z8Jk7vdbumNiNFL90sCsO3DWyHo/PmeUctDS6/
         xMEg==
X-Forwarded-Encrypted: i=1; AJvYcCUxzHC8u46rimH66IiRZb+bOvBuJE5YlROeht7kRYBYB3PInw4iY7Ph/mALbyrtgvXBcUBDn40TJZkvYi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPidCXM8G4XGThqPQ2pOEkbsuRqm+GamjPe9mqem+8BSvXxf0X
	SKg204kIXpkwK9c+1JsTV8lQhPZk+JIe93C+Jsy7kQbRx1LEBLe3/vpu6V7Y9LHafWBTvpKDzCC
	DF+Zr
X-Gm-Gg: ASbGncv53hhFqumGUEbCqhyHpcWOB77zyrEhPN7ajOGGaKJ230pyRcdMu3jk+peqL+w
	jKANHDmanWwr8gOp8pQWF7encLTSE80MiBpgPDP2I9sr495sYex3QD1jYhpo+qGtTvPC3bZHJEO
	3OJmC59DIyMZearjDX7IVNLijXx7Y9oYQIRDRjW0DN5HIHfuGftt1u6pEU7U6b8VRnmUMllxJ4N
	AFBOyLeuChIx4d/Wh16l1oZQzyz9V15W5UveD0I6CHq5z8gIy4QKYqIL6KEH2e2fbjY8+pS9lrh
	6S1yUUa0mkGrfE8UQ8hrMnIv4OWC60W66NCTnK922tAiOUIj3wSQYKIh3cKE9wu8W6N4jvClV7X
	RT9u8u05L9trFD1pARxWkAz5JyHfV89ugAFEj+ybODJuPFepJNcyPZrM//Fm6oSm4/I/EwaU=
X-Google-Smtp-Source: AGHT+IG/GLEg3wUhCq3zxQNU9mkogat7dWnRYMeJFqt+fW2ti/BtmCrgt18+eulLSnVkk+XU7zUx4w==
X-Received: by 2002:a05:620a:2607:b0:835:fa34:5bbe with SMTP id af79cd13be357-835fa345d06mr276881485a.36.1758161087152;
        Wed, 17 Sep 2025 19:04:47 -0700 (PDT)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-83626595a14sm83375485a.12.2025.09.17.19.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 19:04:46 -0700 (PDT)
Date: Wed, 17 Sep 2025 22:04:45 -0400
From: Nick Bowler <nbowler@draconx.ca>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, regressions@lists.linux.dev
Subject: Re: PROBLEM: AST2500 BMC video output disabled by reboot (regression)
Message-ID: <cox6kpackepnunrlhpsssvgdmjd24477cc7mide52xptmmoxyr@ijjotb3xju3v>
References: <wpwd7rit6t4mnu6kdqbtsnk5bhftgslio6e2jgkz6kgw6cuvvr@xbfswsczfqsi>
 <CAD=FV=Xp7zOQ2iEVf896P074RW911F-e2Qa36deD0e8fWksFBA@mail.gmail.com>
 <u7ek3ccya4c3c4rteliskjjfczpmrt4vmqo5c6kjdotxdgitn7@ko24dpb35pq4>
 <ef6558a9-c44a-4c66-967c-187f260f73e1@suse.de>
 <xeipdyk2i2lpkg4rrvz4cl2l3ch62sl4zoa73qvlms3ek3zkci@y7xqbgjulaet>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xeipdyk2i2lpkg4rrvz4cl2l3ch62sl4zoa73qvlms3ek3zkci@y7xqbgjulaet>

On Wed, Sep 17, 2025 at 11:14:45AM -0400, Nick Bowler wrote:
> On Fri, Aug 29, 2025 at 03:07:14PM +0200, Thomas Zimmermann wrote:
> > The ast driver doesn't do much during shutdown. Could you please out-comment
> > the lines at either [2] xor [3] and report on either effect? These calls
> > turn of the video chip's memory access and sync pulses. Not doing that might
> > resolve the problem.
> > 
> > [2] https://elixir.bootlin.com/linux/v6.16.3/source/drivers/gpu/drm/ast/ast_mode.c#L835
> > [3] https://elixir.bootlin.com/linux/v6.16.3/source/drivers/gpu/drm/ast/ast_mode.c#L839
> 
> I can try this.

OK, I tested 6.17-rc6 and reproduced the problem on this version.  Then:

  - Deleting [2] (only) appears to make no difference whatsoever. That
    is, deleting the following line in ast_mode.c:

      ast_set_index_reg_mask(ast, AST_IO_VGASRI, 0x01, 0xdf, AST_IO_VGASR1_SD);

  - Deleting [3] (only) appears sufficient to make things work again,
    that is, deleting the following line in ast_mode.c:

      ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xb6, 0xfc, vgacrb6);

Thanks,
  Nick

