Return-Path: <linux-kernel+bounces-898723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D27E2C55DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D19D3440C6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CF12FF166;
	Thu, 13 Nov 2025 05:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2VYgd/g"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFA023EAB7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763013239; cv=none; b=o0iT9I/gQI7GyfaQxyFvNUA1Gyv4HD7LKMsAf2TtQ87+NmBq/YHG0C/GFt6ak2Oe1UzjDJrHVAuSApga2FKDNUmO/lTCV1mNclPB6oxHLgnrqLsEFXtYPLXdqYIx3cUcVEdMgMtQ6SOXRzC1rIlW1OZ2wMptgc9+IqgaWuCfpk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763013239; c=relaxed/simple;
	bh=G5i5DL7xw9uVAkYcjg+MHuhn04UdAZgfzYJ3MKANfAw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=CasPIxGt0/jXFPHUqmxUENcuz0ViTmXuQoKjP5IsslV+3pbvK5CsM2Z9QJyZiEkRLTKIDobI9zFp9EUTXrdSdMp5fwNYyWpgsX27FxlLNQuhfNNA2pxhH6SvQCD5nuyROAqCDNjKr358ygQbR6Sbb09Efktlx4nUQfv4rZHhIdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2VYgd/g; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7aab7623f42so534942b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763013237; x=1763618037; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2UyP0ogKxI9Y1Qsu6mcA+/ZagVf5oyFn5jJYg/5sVy4=;
        b=R2VYgd/gSHShdVYxRp1tmwr1qySTws7MYLV3MWarXUOXzL3OIEjH8caB0NQOWdPYZD
         rI3PEDELbZyWeK8hNOoaFsXuipZ7cUygFQhnburJc/0kXmYkgHkTGng8bR8SBHOCJj4E
         53fFaNXd2UkmKbycleogi0lqdBIGUfboc0LRIWEsaZ9Oh0wvWlt8hscCEmIncrfv1W0c
         kZCvsqDmdF9hsYo9Ktk8Hrozc8ik0cPhfTAYrszTmXMWzfB+v9LtAeLW9mh5wbGMVKe+
         RhWd8Gl2Gs+A3e0gB5cLb9fUP77n32C7fyxbKmkblnInmAdmF4ZwCtQs09PbiAaYjm/G
         KNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763013237; x=1763618037;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UyP0ogKxI9Y1Qsu6mcA+/ZagVf5oyFn5jJYg/5sVy4=;
        b=mkHQxFVM3LRnaRHWsXYzHCvWazvcRJWEw7ZSrrOMD997lX2o6YUfcipX+0SPCq5N9N
         zciqG8BavltuJ5zWXvL5S37Es1kOaa/rlp4WoIU+t8qRylyBlDhObjIxyPpACu44PjAO
         yBPkriokPdKaxeUiAIK4I8RmdvKOpcvRbuJhXfCf1K5lt52ygDmMJLPG9K/Rno1tQsOe
         afPZFwEuOCOGbk0ZPD+yroceOwROXpWlV8wyx+lDJRxmT0a9mJucZ58XO6gNSf7FqTQM
         EV06xcFEqGSm6nBVIsxAOssn6IYSlwJOlmITvYVTxDJZH3vylh1diIgbfaS/AnOUHh7M
         SzsA==
X-Forwarded-Encrypted: i=1; AJvYcCVoGZH4yQ6NCQYvk3nyROa8/bNDGTjiVBYviXjSVkxRzOLgHDfX6XAf7f0PXOiO2ub3Lng5xvAYDy1V20E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgNrr1NMa6dRXLgPzhFUr2cWTgYJs1P5WHGBwxNPQWP8VeVdAF
	+9LixvwJpqbma2TLPbCq6YtHx/zJy8qa1TyyxQR0bfwKS8dvCH28Dt4N
X-Gm-Gg: ASbGncvm/L4Rh7R26C6vbBScGvdIWOQyxsQG+J46aVts85VDPOGpdsa32O7F5GuIjBm
	W4KD4soGNhaH4FpKiBu/XLXkCJtcsLFQbTDH99KNAC0S0UCURYmVaoZ4hGeK+QDMkugLFnG65ui
	6lSMcBm7UcdI5AyqGs7KXwJpW4pmCX/6ZcYcB9VgUQoDalsr+TM7rs8pzA6xISxPgO+jIdUqoWH
	w+nc6ygcFFvBEjOI1J+8PypaIzUFBsUReouOG0dPLGAQCuBqw0S8c2r+NO3O4vyP8Xb8PwlwtVQ
	tcfTxu5OQYwNG5yVnqXq4BcECKQrKXDFrpEx1EKIKnldslOiVyD+VEYJNXCSeWTfYC70P46GqyE
	7smXHum/QRPOQcpOhsmstJV5xT10CsP4QTSdXFvwXW/kdxA8kbwHAYxGmWgMt/zSHf8nOsLo=
X-Google-Smtp-Source: AGHT+IFlsnZ0k8muJSrddDRx8GFRERSbeF4nDY6yspGg9WIg4wg50amrL5Z1QtXjRUhp3wNQXmZujQ==
X-Received: by 2002:a05:6a20:3d89:b0:2ef:1d19:3d3 with SMTP id adf61e73a8af0-3590968f3ffmr7213716637.14.1763013237233;
        Wed, 12 Nov 2025 21:53:57 -0800 (PST)
Received: from dw-tp ([49.207.219.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc365da0191sm937384a12.0.2025.11.12.21.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 21:53:56 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Christian Brauner <brauner@kernel.org>, djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu, willy@infradead.org, dchinner@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com, martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk, linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] xfs: single block atomic writes for buffered IO
In-Reply-To: <20251113052337.GA28533@lst.de>
Date: Thu, 13 Nov 2025 11:12:49 +0530
Message-ID: <87frai8p46.ritesh.list@gmail.com>
References: <cover.1762945505.git.ojaswin@linux.ibm.com> <aRUCqA_UpRftbgce@dread.disaster.area> <20251113052337.GA28533@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> On Thu, Nov 13, 2025 at 08:56:56AM +1100, Dave Chinner wrote:
>> On Wed, Nov 12, 2025 at 04:36:03PM +0530, Ojaswin Mujoo wrote:
>> > This patch adds support to perform single block RWF_ATOMIC writes for
>> > iomap xfs buffered IO. This builds upon the inital RFC shared by John
>> > Garry last year [1]. Most of the details are present in the respective 
>> > commit messages but I'd mention some of the design points below:
>> 
>> What is the use case for this functionality? i.e. what is the
>> reason for adding all this complexity?
>
> Seconded.  The atomic code has a lot of complexity, and further mixing
> it with buffered I/O makes this even worse.  We'd need a really important
> use case to even consider it.

I agree this should have been in the cover letter itself. 

I believe the reason for adding this functionality was also discussed at
LSFMM too...  

For e.g. https://lwn.net/Articles/974578/ goes in depth and talks about
Postgres folks looking for this, since PostgreSQL databases uses
buffered I/O for their database writes.

-ritesh

