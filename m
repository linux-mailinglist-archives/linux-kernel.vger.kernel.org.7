Return-Path: <linux-kernel+bounces-845512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEA2BC534C
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E2E19E3E74
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85E8285054;
	Wed,  8 Oct 2025 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ccjXMZfI"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4C2848B1
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930205; cv=none; b=WMbePNizBngFy0pf2HlozgQN1ilFcIXX4sKiP9GQVlk/aJzApxsgcLLCegmbTNeUaX/dp/luQwaTz3IoGyaainzjFoLQMbhy0w88wW5OioOUxOfmqb38hmHtrV9w58t1PdTccR94nxBHK8hrLDo8GCRKX+h3kmkbwV/IUtFqYeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930205; c=relaxed/simple;
	bh=BR+vWqku4LvXNZ2Kxr1BNaADTOJakXGWgH5KTQfQJiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA0QKjbVHTEo+A3hmPW0eE+Y84BBwa5DpmMsRQ8R6mg+0Ix/EhrFpy40D76NNSwG/zAo5Y1A9lluXEZEO8SfnhD18CUrRhDhtu1yEC8lTlfl4G7iBSc+8L4ZTldGG5OSyLhm69FYcmTw9oneT/DqoeLqOfmA+TTuXP74chR0w2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ccjXMZfI; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c0e357ab51so487663a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 06:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759930203; x=1760535003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BR+vWqku4LvXNZ2Kxr1BNaADTOJakXGWgH5KTQfQJiI=;
        b=ccjXMZfInHOs7xmwWMiYM+8Bs/DCsV722cefic0qXQ/Y5k0j0vKh5QF1dgsLbfJDnN
         EzLRzJm1YqCDEPIrlXeWAdFY8GbekmhRfm4/N6NUCEt2L/QrWSnOXKOYInI1xSECH0rC
         WrlC1opaE3NoXj3qSDFIj5HQfxBZargBI4Gm6Fd2DPq30v4LRH4vI/X9GnhTkn/mDbk1
         PnAOsaLOihakt/JcpghJyQcwJfZetiFNeM+umS8jWCuqf6wPwB1FknDrGTKjBnC+lwB3
         6vhX2F2WZcpUC8YsWrzFlLRSvbAubN4TQeQzg6xLCIhNMSLGgILS0J0Zh3A8RFykwf04
         qxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759930203; x=1760535003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BR+vWqku4LvXNZ2Kxr1BNaADTOJakXGWgH5KTQfQJiI=;
        b=QguQN4cSoURaelM8i7Bmz3dO/eXJ9FYy4DH19qQmavOrwmw4P7TIrMNprY0O+3JPDX
         zF7k21wzAG7/ai1Ao0V+DOxODFqgv1++QEcofnFzwSj0PAujnoqMkMyKfpg5hnGggWFG
         4Kbn1ffNhJvWvBVYYJjqogiebif0ZAd++goccKbvRt0omdNEf0mhOyJwjy6uhKqAjoMn
         G3ACP6QvJqmeFY7MQKVaRCth+UyPYJutKhtUlLyQXbZSKSDY7zIZzndHk0fllONhNaic
         ELChwaGquKj+s+ExMMi9tizzgiqvQlgVAVGs9Q3GskCNvzTISxfkJkLGXkCfeFBz9BwV
         0LkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXbjHYf1oqNOyo9NXrBXyLZlbWSr1MLr0PcJI9dmBsqEUIomdnNSQ1YIKFGKctsRSF2Ec5MwP5ZQ3lrhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgnzaB6n3sdDhd7DnZegs385e65YI15coV+GAsuSMqoytULDaW
	8oIXxApukLu0d5D94KqQ1dmeRDoFd/Gg7vWcgynskOEbDl85+MoWpkvgwTVyiuK+CMU=
X-Gm-Gg: ASbGncvJZNzn0F51KESciM40Dwga325L4y2TtNzFbOgBubvBU3PvtNqlX0EKl1ZRhse
	P/v4rcAIHCXPWrWea0sNeHEMbs2ECFTqtaFhcPbsB8Wr6/ad1o4H+hVWP20E9BYbeyI7JFnKB2O
	3uh1HVafpUknvkcn+NhhQO3Ue+0GcGU56qkwdI8pg7At+bH7w3pJGLUY/8M4gCEUNb60Ff0/wyj
	UoqhRD9xp/c21KI3quYBR610omPKNknf6zVtefaTGcyEP5dNTTk1hALVhk+89Gyy7c89hH8USLe
	Gm4cLOhUOgIIXy9IVl6n850nLQTHztUlE4A9Mim0WSUhWOiT02ClHwaIUVzZBx1qmqGXewRVN5c
	YTL64s01IY/cpcxWNhDroNqX83zaXYoia
X-Google-Smtp-Source: AGHT+IEHXHi1fX92viHn1FlNncpYH+JLVa8oK1Fr/RFGZjN8SkFmL54M+5MvXjcHKBsxQCY4yNEe0g==
X-Received: by 2002:a05:6808:5245:b0:438:338b:edb with SMTP id 5614622812f47-4417b2f8ac5mr1803574b6e.12.1759930202725;
        Wed, 08 Oct 2025 06:30:02 -0700 (PDT)
Received: from ziepe.ca ([140.209.225.78])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf3fdcf749sm5768186a34.9.2025.10.08.06.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:30:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v6UEy-0000000Fw7f-3aJ8;
	Wed, 08 Oct 2025 10:30:00 -0300
Date: Wed, 8 Oct 2025 10:30:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alessandro Zanni <alessandrozanni.dev@gmail.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	kevin.tian@intel.com, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fix to avoid the usage of the `res` variable
 uninitialized in the following macro expansions.
Message-ID: <20251008133000.GB3734646@ziepe.ca>
References: <20250924165801.49523-1-alessandro.zanni87@gmail.com>
 <dc360969-c1af-4b87-a259-cc265a8d553d@linuxfoundation.org>
 <rfwgp73zuyctbjgxvdgs67gq7g6glfxdd5peimqjiw5inw5h4g@cgmif7gyplct>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rfwgp73zuyctbjgxvdgs67gq7g6glfxdd5peimqjiw5inw5h4g@cgmif7gyplct>

On Wed, Oct 08, 2025 at 03:24:29PM +0200, Alessandro Zanni wrote:

> Let me know which version is preferable.

I already applied your fix for this, no need to resend

Jason

