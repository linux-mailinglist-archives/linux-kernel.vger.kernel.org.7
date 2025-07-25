Return-Path: <linux-kernel+bounces-746274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9069EB124CE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4B3C7B399D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2F8248F72;
	Fri, 25 Jul 2025 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fMRSmoJP"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C06924886F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753472292; cv=none; b=hhwqMQL1JThS/xhtXWTZaQBThcLlEuwsATOVoeR/EtJyHSDkfgfte809T1Y3GgSv2ysyvn3oCmsolpSzynTE1eeNjb/eXE1gRmNJ4v+CIMkM/Zpq5FNbzlAZQBoUJoh/rupaD5kSqjEovpVTkuC2jsbdvfhYZKbJ8ZiqeGUeCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753472292; c=relaxed/simple;
	bh=Psj/ybT+w7yHjRGqEoZdkGoZJZQMfTo84hs5NgEdwDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1mgM5lckWLqXugMTiMk/aHaactjW/aWGphyepfFl4vMHQ98h8eLDp4n3pxPf0yxgoKNN9NzWUvXgJBvDy8JDKsqAEEu+wi0Gki8GxOSfeNnmzB72afXmsn1A+F083Sp+/OhtA9FhP+FigATk+lZku3x+KbE5m+TQubwUd9qVt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fMRSmoJP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23dd9ae5aacso3565ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753472290; x=1754077090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQFQwXEBbAbFlzETHfAUWAGm940UIaytQtny6e8kG6A=;
        b=fMRSmoJPwqKy0AjKlw/ZvwLac0KtgFxSx+m1G2Iw8H/TTanXyQ2NxUWESU+ibyxIZG
         KNHh+bn/+Kaoi157zOJVur9MW+B13eEXdKn8klbuwy5bUCCVBpjaRGOi78E828BVrf54
         5IvzajI+hLRGctw8uXjJAIoR297KUIehKweBA+qX/j8c4hCVNLjHPJQPOazOoCM4i+N2
         FS45vr/COgfCqj9dwYN4TYNUtUHoqzO8aNGyTBZybZ40+cETJ8XD7NczkBhaUKtYM8Id
         oSGFsvLZvHOBntIVuzyAwBjKN7REluosSbm8JNxnTYsdF7CwuC0rDVvIQMimToQDWxhm
         DXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753472291; x=1754077091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQFQwXEBbAbFlzETHfAUWAGm940UIaytQtny6e8kG6A=;
        b=i+9lGzfOlIe9a7lr1o8bxNaejnUgIor24b8+oBXBzWP5VfU6iCUov8CNxIATP2uCQQ
         JraXFQwiu7BbferlQPPM2kmllIRTuvn4W691DPLnLpBAbISaWNN7sImq3r5bfkWHvjV1
         JS2mW+7XVL0rWQk17AwmxXcNOmdWm1JfZ9ICw96ii0cptY80WbqbnSXoiFTcd6lMSsYx
         ASnGi/Xyb6WzviJUwo5sthg+P1bFjR/ugEbtSyRWsJ5EmBlo+RNx0yKSRuuSTPE1btHK
         0PljTPP9sMGBNgn5ls8rvVD5l0fcYKRQ3qLWssrwBNIsWlm871lRRYJN3rbG6Vu/i4H+
         +/8A==
X-Gm-Message-State: AOJu0YxmnMkrGXK1Rm7ZC81ZApw6/DBBORW6wMFHIMA8Z1QXxgXy9pxl
	7u1tWv1HlFJkyKm5nH83Bs/Ds9dVIuYaennnOmz6/lWsetUQKAQn4o/hhAm7HPt0RQ==
X-Gm-Gg: ASbGncs33WHQzgIze05v6y/t9uccji3TdkfaLqB2MwbDhJhb8iDwXsEcMMWiAYJyerr
	IsqcLHLMyc502yU0HbJIMfGeg9KsBT3O96RxVqJKoiOhgDo2OMxWacqgiuSkgv1keX/hES/xu3l
	+nRuz0jHVddITQYXbQdrSU1M0SMpeVxSimdmuGfoW5bVUEmKVdh5Xfx3zMWyZGhH0xL9VYV+qbK
	jKIL4VraMY6mygj4Z7+Yo9FxL1cUn90Q+KEOvJIrGllZLCKQh71np6Okt++Hm4xUxwux0eFKwHQ
	EJ+h4v4tIgEWvYSMfXnPIy/u80Kczk8p96dPVttdVk8hvdUsmEmLz9jyPkW9y1iYwPWo43MOoEW
	Xrxb5T4j+TdUEpEZOknhYu94aVIElVcIbfG43KzO7DHlWuR5kjf39tuY3FByw4Pg=
X-Google-Smtp-Source: AGHT+IEFhyjXrGNPqAlBiUwoozk3VWBc4fA7b+qdbNZ8AvcpxxGDpK2FZYIsprgrDuYDVcNnZV0t5g==
X-Received: by 2002:a17:902:fc87:b0:234:8eeb:d81a with SMTP id d9443c01a7336-23fbfd1952amr423655ad.16.1753472290353;
        Fri, 25 Jul 2025 12:38:10 -0700 (PDT)
Received: from google.com (135.228.125.34.bc.googleusercontent.com. [34.125.228.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f58d831sm416736a12.23.2025.07.25.12.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 12:38:09 -0700 (PDT)
Date: Fri, 25 Jul 2025 19:38:02 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>,
	kernel-team@android.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 1/2] binder: Add copyright notice to new kunit files
Message-ID: <aIPdGso5qmAjq8sz@google.com>
References: <20250722234508.232228-1-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722234508.232228-1-ynaffit@google.com>

On Tue, Jul 22, 2025 at 04:45:06PM -0700, Tiffany Yang wrote:
> Clean up for the binder_alloc kunit test series. Add a copyright notice
> to new files, as suggested by Carlos [1].
> 
> [1] https://lore.kernel.org/all/CAFuZdDLD=3CBOLSWw3VxCf7Nkf884SSNmt1wresQgxgBwED=eQ@mail.gmail.com/
> 
> Fixes: 5e024582f494 ("binder: Scaffolding for binder_alloc KUnit tests")
> Suggested-by: Carlos Llamas <cmllamas@google.com>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Tiffany Yang <ynaffit@google.com>
> ---

It looks like Greg has picked up this patch already. fwiw:

Acked-by: Carlos Llamas <cmllamas@google.com>

