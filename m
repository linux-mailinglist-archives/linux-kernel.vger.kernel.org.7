Return-Path: <linux-kernel+bounces-800310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7DFB4361A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10557189B241
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2A22C3757;
	Thu,  4 Sep 2025 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="AgZNxVTe"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592412C17B2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975254; cv=none; b=Wt6AUv/vhOzP2fdVsBKOGt5ycjcAKgUeJAeMc7HT0Yv/olQDu25krbYPw+A/Izv0A/WMMUBUtjkZlT76ovUlW7L8Ejeli32+C8rO1pZhq2cuQ6ZLKlQan6YvTm9LnZGeK/HBoScRfpezyzIM2ug9P1HH4vSUQeT2FBQZNXU2xA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975254; c=relaxed/simple;
	bh=3fB9b5I3Kn6WS0pnGa/2P2nNzuXa+Y8Q7kd4ZY9H7p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gmusc3SR/RXWiEG0zDiDcZ+HsihA/32ONGxwcW2a0oPGBnckTwlVk3ibIihvAqL4PTPRmV428HADMoPmZyvQMy+Mv1pub/pTUzPeqCdH6a7cEEN+DlsPg/r9pNkOe4KoSCp8lbj58MFK+qqzTknwQeUtE8mu9O/D5rY/CgtlYTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=AgZNxVTe; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b548745253so12234531cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 01:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756975251; x=1757580051; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=95wfGGVFVGnvDRkOAo08Sli4i7CgJ0TfhXshmox6PTs=;
        b=AgZNxVTe6ehBECZPK2kuQZ56J474nBkZL//6h82AAhujskSvqN2BWFIkSf2wzyC+GP
         yxK5A5YW24A+ugBljsSGBSOywzUfnpymswHzbLGrEG8OlLbT256x3ATx6TqT1zjSzVnZ
         4C+DjYFqbDMIIFO+atkIsj4/oc5d1+RrndF20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756975251; x=1757580051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95wfGGVFVGnvDRkOAo08Sli4i7CgJ0TfhXshmox6PTs=;
        b=OzhmHhhPVms/easLUEH52Czg9R1Oi/Hzy/mvghYOJYMUnWrL+5kp0D/xel8WVPGfQu
         4n+L95z/EnNB4HJX21CHTqgjUpuWjkdtLtkbe+BGOS99xu2hB5fyrUeW9u4EKYRCQWoP
         jAcOtLgV4z/KeAl9fs38VYwyfiQ569t4Bn3zmbqoCApmwHmqUGHYHzaMnM/s+DSfde5y
         eOoDBDWNMZaQIMz4HGeW0d7U+1DtZFryxjMhgA3ch0NyAKf4G/apBaKaAbwWreYU190u
         lOWEJH+5XhPtRlP+86jTmR/ka1uG9AQszDPjhOWTyZHk3M86lGlBEr5IiioxdrkgrOsB
         NQNA==
X-Forwarded-Encrypted: i=1; AJvYcCWPIb24lpE+KQXLMZEUv/mdgDOd7ErWczg7nwdnKXm/XYvz27TVHkzphZCwfn294ACnj/9Lbxixy2EpGqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwufgUsO5ltoBvx53DsObhzVthvPhTeoZP2aLlpNWb18Gb4xQA+
	n1LDdZhUzlVcY+PV0jvbIp6f3Ws57gs1aavpIe7mDqo2B8quMqZ6+ZlzJnsHwIwW1nnX/Anhcfu
	HxlzBgG9OLZ9j9V0OC9YsyNJRrPJMFu7zE4sNcLgvd0JpnYDXlbqy
X-Gm-Gg: ASbGncsjc7CBwiRY4Ma5C80dgShWquciv+wqChqB1dSJYOqcUFEN7JmOOyFfH0V+bSA
	lKVGHuggmVnY3Pu85ZbeyE610La8AqtWrlek+q+bj/APNsYDEFU44EXEU7PZrLubVCnsMg8UDx7
	Fl0wP4iME3Jgn7gFkTURpv9P6e/3KrBnT18c9XwBhRinRRqGgNR0ZqG+20RmBRZqV+bgBZ2iRp3
	3oTlHe9vg==
X-Google-Smtp-Source: AGHT+IHC7FslwL92EMoWkWJFtaYJAHdu7nFeoKnQmVrR5RuWkUsBsDaqbOthWlmGQ8AhNWljwDOe66mKF+bZCw1p1eM=
X-Received: by 2002:a05:622a:1441:b0:4b2:eef0:74a3 with SMTP id
 d75a77b69052e-4b31da1d388mr239759031cf.52.1756975250946; Thu, 04 Sep 2025
 01:40:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903083453.26618-1-luis@igalia.com> <CAJnrk1aWaZLcZkQ_OZhQd8ZfHC=ix6_TZ8ZW270PWu0418gOmA@mail.gmail.com>
 <87ikhze1ub.fsf@wotan.olymp> <20250903204847.GQ1587915@frogsfrogsfrogs>
 <CAJnrk1aa97AwixCq9+eGQT52LAfqL-S1Ci5fSUygfFOo-6kMHA@mail.gmail.com> <878qiumxqx.fsf@wotan.olymp>
In-Reply-To: <878qiumxqx.fsf@wotan.olymp>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Sep 2025 10:40:39 +0200
X-Gm-Features: Ac12FXzUpDt_2mK7Xpn2XvEqTpsMqt9U7uWkfOumky57k0KQPFZSynmixWe2nUk
Message-ID: <CAJfpegsJigpXwhc35KZH4LOihjinz7e0OCBPT5fLHkio1GGkfw@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: prevent possible NULL pointer dereference in fuse_iomap_writeback_{range,submit}()
To: Luis Henriques <luis@igalia.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Sept 2025 at 10:24, Luis Henriques <luis@igalia.com> wrote:

> I don't have a preference between v1 and v2 of this patch.  v1 removed the
> WARNs because I don't think they are useful:
>
> 1. the assertions are never true, but
> 2. if they are, they are useless because we'll hit a NULL pointer
>    dereference anyway.
>
> v2 tries to fix the code assuming the assertions can be triggered.
>
> So, yeah I'll just leave the 3 options (v1, v2, or do nothing) on the
> table :-)

WARN_ON is a useful tool to document interface constrains.  But so is
dereferencing of a pointer.

V2 style WARN_ON should only be used if it's difficult to prove that
the condition will evaluate to false and we don't want the kernel to
crash in some unknown corner case.  AFAICS it is not the case here, so
I'd opt for v1.

Thanks,
Miklos

