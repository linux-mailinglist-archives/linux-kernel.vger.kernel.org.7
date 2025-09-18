Return-Path: <linux-kernel+bounces-822035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 792CDB82E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382821BC0569
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5472777F3;
	Thu, 18 Sep 2025 04:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="idI6twVp"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35011172A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171157; cv=none; b=cwjxzxMbhbOaZn/Pvv4MlTETkkybsv/om6h9V39IVUKKXwdVxAR0yudQQdCtc5z7DuPZWZpL2ZJw2DzYj0/u9JLBdGkZp5/3xPf9nNu01ERdwjlID4jTPS0+9ZyRZbzlwF9zuTHXWpoN+7gIyppzqDi1kpEahuH0PXkJoxrjZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171157; c=relaxed/simple;
	bh=roMRSfTHwvWbIYHIw5SlvXsbEkqQ/myQD+bxde55/zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNTswbvfDpCiCqj5JSre2imgm3vZLEyzvpqscfFkm3byt3Js7bw2bTG0AcrJb1RU2jJ6Vh+tTwt42pUjj/JkABiwazPlFG/8ifzsQx8CTMDSwFPRsQvs7/e3IsBvjxKIUFkY1n2IRzaLjZneFUqYPD717pdT363P+rh6ykHlJMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=idI6twVp; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b07dac96d1eso245655466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758171154; x=1758775954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9QRU1VKJtdE0ZocHMFrYMEWDnZZ/HDzFw4qL2PHiIk=;
        b=idI6twVp7T8x/SEXiTdGr76RIW/PQHsBT9ZgX7wHMdhcQriS/6tAHinzSMFwEXrkhJ
         zd6LHHTSr2P3h8YjXbj8yiCmrZzQycEN7zaIYG1sZP+SxkaG0rh0uSPavCn5678DDtvP
         qbKmMP4yZ/JgKinx0SWgpQi+ysvzHZyfp7ClW3vZNGn4QXs15wwcrM3dMLfsQcOz+aie
         10fc0LE2geYsqA0D9afY7OwhLlJ6olB/AWxap93eyCKwT18WhN0XP1H0a2M/aAwbdTFE
         9Sq56lwclcSKDvksOkFNl6XRO4MF098SdY8gN49GKESi09nKIBwodaWppKrEM815B4gz
         q9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758171154; x=1758775954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9QRU1VKJtdE0ZocHMFrYMEWDnZZ/HDzFw4qL2PHiIk=;
        b=oR1vF863h/uNv+A+BLcW+s7ywFRWMXzEHiMfTz2RBbDtfr/cI4sz0jQuKIFL/8mti9
         Jh7FtMHFEjmGih5nZaLY3D18JGmbcQdSUCmYr29yISwVducPNiq9ay2g5zO839aaSXAW
         CR7kn1c0zoJnRHrtakZe31UDP1lcBag7xrVVrTEOOamw8ka0VxxoFPZaYkq0lBZ/DQp/
         rR6Q4qM3cvk1vIaPpK9Hat2BOO1hrf1NMUfTGuqd1Vilx5N1Ec/nvMjmynTs1BNn3J5Y
         RXKkYOA9A4m5mLnDtV3hwn9IqeUCmhxy+LNAl8ZzLZacdlFFdVWjYHp5pAjS8+lNCHXE
         3N0w==
X-Forwarded-Encrypted: i=1; AJvYcCU0Yqg7dh+CTu3rZIGnX8CQJcun1GoeEg1uQvEOXvh9xOAXFJqoAJAs66LJCnb9dU/YCam5esMSp7G9Ko8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+mBX5laCvCQXMgFBUKv96qPXCtkjmHQb3371KeFkB75mdv8rl
	cUxG4s2wMjlAD3JQTCFSZc+zNwmzvJJMMQT/oHDZ46TzLAw9P4u04h731KlzZjWly1wuE5Af2CY
	5Q2vcUFIPDDixKR3rddK52tDuPZDYaigBRsEJ7jKUGg==
X-Gm-Gg: ASbGncta4IlnMmBQ3ozj9S15UD6bTlq23uavaKrGyKYszNjvEO+yLJR2QW0jRjgNvq9
	cgDza4ugWP26GZ0SRnj2ZYUFIjtwflyfYHvl7MJetS1oBilXbDrORRGypV058vydxBoQqOnAvQG
	XLcQZvAzXBrx9RDzgmADzB19/wCr7vFlYx9rJw3LBvmjnCpGv7/6MM8eXYRRbX8hrfCKxwoyx++
	ugSJFv8LNtA9PhQHgiyupnCDcwSwUzsDYkqhR8CL4XQEPIjsdUzAXE=
X-Google-Smtp-Source: AGHT+IH78/YwtfdEEvgvHSMTlAUPH/eYqgNUZ9char1Npv5jG23ahXW8pg2svda031uaJNRKWZjE53pxWARfwi2BnY0=
X-Received: by 2002:a17:906:9fc5:b0:b19:f444:5bc8 with SMTP id
 a640c23a62f3a-b1faef71aa1mr223957466b.31.1758171154075; Wed, 17 Sep 2025
 21:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917135907.2218073-1-max.kellermann@ionos.com>
In-Reply-To: <20250917135907.2218073-1-max.kellermann@ionos.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 18 Sep 2025 06:52:23 +0200
X-Gm-Features: AS18NWAZzXNs77ONQtxSPqI0-tNgs2QxD25qWiDPS307ZO8zwzS3_Wc3r2CSBy0
Message-ID: <CAKPOu+9o4FfXQU5O=iEhi=aFWfTUZ-mJVD6qqVi3UTSsy44agA@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix deadlock bugs by making iput() calls asynchronous
To: xiubli@redhat.com, idryomov@gmail.com, amarkuze@redhat.com, 
	ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:59=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
> +void ceph_iput_async(struct inode *inode)
> +{
> +       if (unlikely(!inode))
> +               return;
> +
> +       if (likely(atomic_add_unless(&inode->i_count, -1, 1)))
> +               /* somebody else is holding another reference -
> +                * nothing left to do for us
> +                */
> +               return;
> +
> +       doutc(ceph_inode_to_fs_client(inode)->client, "%p %llx.%llx\n", i=
node, ceph_vinop(inode));
> +
> +       /* simply queue a ceph_inode_work() (donating the remaining
> +        * reference) without setting i_work_mask bit; other than
> +        * putting the reference, there is nothing to do
> +        */
> +       WARN_ON_ONCE(!queue_work(ceph_inode_to_fs_client(inode)->inode_wq=
,
> +                                &ceph_inode(inode)->i_work));
> +
> +       /* note: queue_work() cannot fail; it i_work were already
> +        * queued, then it would be holding another reference, but no
> +        * such reference exists
> +        */
> +}

Folks! Guess what I just found in Linux 5.13: commit 23c2c76ead54
("ceph: eliminate ceph_async_iput()")

-/*
- * Put reference to inode, but avoid calling iput_final() in current threa=
d.
- * iput_final() may wait for reahahead pages. The wait can cause deadlock =
in
- * some contexts.
- */
-void ceph_async_iput(struct inode *inode)
-{
-       if (!inode)
-               return;
-       for (;;) {
-               if (atomic_add_unless(&inode->i_count, -1, 1))
-                       break;
-               if (queue_work(ceph_inode_to_client(inode)->inode_wq,
-                              &ceph_inode(inode)->i_work))
-                       break;
-               /* queue work failed, i_count must be at least 2 */
-       }
-}

This looks very much like the code I wrote - only with a loop for
queue_work() failures that cannot happen here.

Jeff Layton removed this because "Now that we don't need to hold
session->s_mutex or the snap_rwsem when calling ceph_check_caps, we
can eliminate ceph_async_iput and just use normal iput calls."
Our servers proved this assessment wrong. Calling iput() while holding
a lock is obviously bad, but there are more reasons why iput() calls
can be dangerous and inappropriate.
I guess I can add a "Fixes" tag, after all.

