Return-Path: <linux-kernel+bounces-895817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A5FC4F022
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89E5E4E8F08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5026D36C5B7;
	Tue, 11 Nov 2025 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bXWWicQC"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C14F369991
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878060; cv=none; b=hhqj9TKh33jZ4FdTiWakeVBc9i9sD0EMthyqUaMGw6Nj3HNCEMo3wMBj7nRwDNWRXTsa/xXD2QcEWaqREfsV/aWnpiLAg6ra+q6C5i3aV3z5/zC09cCFho62AFmOHvBEFB7wukhZNmiNro4jWJ0ciCGK/DAlsUQrvX49yrpPchg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878060; c=relaxed/simple;
	bh=3ucEiOfLKgb7okcKL0HP1li5Wut0HDdF9YfITezYGeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ftj7COXoytmtOBZaJgehPDlrgA9N+hA9lPuYr0xXgo1zTkMQsAPLSFZt//qXMTU16wJsGUwUL+o4l3Cf4Enmd/F2bk8qVhyIqFl6ycBL7RrRgoYPmJcdLzpVYvSwsW3BZ9+BjFKVn0I0LVS3exEq+MS80/tCOoyGhaXCUgGPQGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bXWWicQC; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-431d824c8cbso199065ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762878058; x=1763482858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lujxXLJQIs/1fMr9wnpYhmMZiP7/CAmNV72V4s+rx0=;
        b=bXWWicQCCI1NVuvdpiXUJFgSi/2S3dliDDXf2zGoRQBszb9bpL36H/8ctkOqC1g7QR
         g2zja7KuDFb/qUbgYAVvYLMPttGbvfEMORLpPZezgGpw0mChhjgGfKopaAo2+pAf/K9r
         kHhxo281biegGH888D//9xxiUT0YEI6tCSpVYu0XIdYBIzSyA+jIv7C2nIASMWYFxgLl
         /ZsW3xigz5t8KKeqHdnCrzq07a2XE5nlrK8K8WsPa9fZidZIWt+T8wtUBCZV6ZvZsZ42
         /7pt7f+T4BKtukMGJTC3lnO758ygQn0MWOoLswoi1JmBxx+8blJe6rFsQpOXvCTVyYCV
         9z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762878058; x=1763482858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0lujxXLJQIs/1fMr9wnpYhmMZiP7/CAmNV72V4s+rx0=;
        b=YrFd6miKwifsdzD9xoI1fTDBC4mM6T5DtPSdQuIdWsyacJdjDm12ABbv7O8D7v2gjq
         Mr1bJSvzMZRixrBjWU4DFCHQHceQP5faWC5dEwZMO2oGAp/egkbsnEwlvSKl4r4Tzxj6
         7RFoQMczI59ewlp1JvDKAdHfGVg2pR0LnNkBxMAKl0GRo0vCy/wqiikl599R4nFQJEjY
         X7rUQW/m0GNBw1vG6/fhlpl20gXl/wzV5JgqcvKgXSuiYMmjCw67cN3fpwTFUmnIcWxK
         AxUP4Dp9Njp8nlenjLdhNJ3IHvat9RmmUdPrwmhcwJxH3DXzJI+2lXIoruXgenVKqxwH
         HRHw==
X-Gm-Message-State: AOJu0YwpBlyrFSpRQT/DWldAAW9U2YJ8xnrTX65FtQFDqXN3ZMseJTad
	rvCFfvw6HLcnPAcDSMJ1rzcxZuzEe39ZtVcGD/A5+VJmJhx3WtNjQAjS0K/8T2hSbq7DBASNcCG
	ErA6otn4b8XCKuVItj4+dv8txy/f8OEtXpU1eTAZZ
X-Gm-Gg: ASbGncvUYkHLZreEiBCPmAeaAkyHdhLK/fhUIRLa7S8oFjLH2ApObgyO8FMHXcoL7gJ
	zDFYeKWUG+0488oTn2vmlzgglM6j+UnXDEX0Y7vEOX0OjYw7vuwfq89foCM3BM31/4yRoqGNd3P
	EbrapdvPaFBxMTtC+we0GdKk5jBcXuutWAnoVcE++hFPfxYxPLd+HFyAdAQDPlgCt50Vhrmwc72
	pix8E6s5ZtdSsGZWcp28BCqNDo0gIJIco9fI/h63pxa+pZz7G7PCUCgs+e+IyKSX2wKYu72CY7U
	PMZtLy0=
X-Google-Smtp-Source: AGHT+IHurGNVVBdU/NzdCYlOb6sZVxCFf3XJcmvsONpMJvPgax03NCfmaJXep8GUrwJthMRwu/u8+YkBRZaU5SmPgJw=
X-Received: by 2002:a05:6e02:3289:b0:433:138:eb18 with SMTP id
 e9e14a558f8ab-433be4aa427mr7299635ab.9.1762878058046; Tue, 11 Nov 2025
 08:20:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111062815.2546189-1-avagin@google.com> <20251111-umkleiden-umgegangen-c19ef83823c1@brauner>
In-Reply-To: <20251111-umkleiden-umgegangen-c19ef83823c1@brauner>
From: Andrei Vagin <avagin@google.com>
Date: Tue, 11 Nov 2025 08:20:46 -0800
X-Gm-Features: AWmQ_bkLiXV5lJ6MfoofQgJ668iYrumTv_Un2FnwFwIhq_aBfOusso0zufkwo_Y
Message-ID: <CAEWA0a5ZjWuyFM9b6076GT6yEn0jYZu06C=huPxpqyxWQiM7QA@mail.gmail.com>
Subject: Re: [PATCH] fs/namespace: correctly handle errors returned by grab_requested_mnt_ns
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

)

On Tue, Nov 11, 2025 at 1:13=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Nov 11, 2025 at 06:28:15AM +0000, Andrei Vagin wrote:
> > grab_requested_mnt_ns was changed to return error codes on failure, but
> > its callers were not updated to check for error pointers, still checkin=
g
> > only for a NULL return value.
> >
> > This commit updates the callers to use IS_ERR() or IS_ERR_OR_NULL() and
> > PTR_ERR() to correctly check for and propagate errors.
> >
> > Fixes: 7b9d14af8777 ("fs: allow mount namespace fd")
> > Cc: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Andrei Vagin <avagin@google.com>
> > ---
>
> Thanks. I've folded the following diff into the patch to be more in line
> with our usual error handling:

The diff looks good, thanks. I have another question regarding
7b9d14af8777 ("fs: allow mount namespace fd"). My understanding is that
the intention was to allow using mount namespace file descriptors
(req->spare) for the statmount and listmounts syscalls. If this is
correct and I haven't missed anything, we need to make one more change:

diff --git a/fs/namespace.c b/fs/namespace.c
index 9124465dca556..3250cadde6fc4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5738,7 +5738,7 @@ static int copy_mnt_id_req(const struct
mnt_id_req __user *req,
        ret =3D copy_struct_from_user(kreq, sizeof(*kreq), req, usize);
        if (ret)
                return ret;
-       if (kreq->spare !=3D 0)
+       if (kreq->spare !=3D 0 && kreq->mnt_ns_id !=3D 0)
                return -EINVAL;
        /* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
        if (kreq->mnt_id <=3D MNT_UNIQUE_ID_OFFSET)
@@ -5755,9 +5755,6 @@ static struct mnt_namespace
*grab_requested_mnt_ns(const struct mnt_id_req *kreq
 {
        struct mnt_namespace *mnt_ns;

-       if (kreq->mnt_ns_id && kreq->spare)
-               return ERR_PTR(-EINVAL);
-
        if (kreq->mnt_ns_id) {
                mnt_ns =3D lookup_mnt_ns(kreq->mnt_ns_id);
                return mnt_ns ? : ERR_PTR(-ENOENT);

Thanks,
Andrei

