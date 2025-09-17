Return-Path: <linux-kernel+bounces-821619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5A4B81C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559471C80286
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FB72D6E41;
	Wed, 17 Sep 2025 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="E93ViBQr"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEF029B8FE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140749; cv=none; b=azgwrqXt5GCwX5tiznUOQVkJtqJfxxx3VwpxiNEqpMexI87Bg9FXpPqIbSfec4wyPVAjz1FKOpPhm12dKTIhHz4dYXMDh630WaEiiuX6wiyWQ8Yd9r8jb7OtGn5nKBtTPqTe2QZvxJ4I8k6QF7YVnuJheG5CVf5bAavTMF2HKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140749; c=relaxed/simple;
	bh=K6d/jzhMMI4CPpQDgjpBmEl98KL3cG+euC4yxGzEVCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPcVHBgUoRRymFmyFeXXPpCFl1/qz+1RmiGEwFOBYBrJyX5hWXptBu55AGBc2LjFh+XeH5qmz5tlCU3FGbBivgnv5qvu61dBRknGRCFbJE7zPpT4J4dVhzL9aIdLJvTe10hww98+FkcnydraUqiU2Ln/V8nTsoap89Qj7EDElPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=E93ViBQr; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so251969a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758140746; x=1758745546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhNK71BU031VL7GqxBW1Krt0QEpivweMDtH+UA/VF5c=;
        b=E93ViBQrlMJp2YF9PBilI+D4r4dqMY3kENfrRihA/DLYVvQ3tFSLBlr25yGkNQZSeR
         EvQ7C8EP9iYqCNcBmELAqwIYVELvBY01wXh1NLNH9pQelcTa3DBev1jJ9ZHywMfyQxiw
         jMskuvUL5nGW6CCje86E6qhKG7P8MZmMivlYzSl8zDKmxPEz1hyVpavb2LVlVOkvdWvq
         t3mPCff8/kzD1pdYyXAaFS5AF5PgHpsbs5DZiPHn0GSw5470xGRJN8PyzjDov6RbA/pg
         +ABF1T3cG5N6e6IE/Agbc6raLoM9Z7HCVkzSaFJMfkFcaUrwPUh4WxDRuf55acq4s8zE
         BmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758140746; x=1758745546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhNK71BU031VL7GqxBW1Krt0QEpivweMDtH+UA/VF5c=;
        b=MVGcdwMmZomzq7jMiYV6bjS/p3jBi8khQl8Ig01jKNaFMRXzkt6r9hQ2ON6kf9JAPE
         3/BkLIc0vT0qiEio1U92XRBm1cvadOTwLNsq47grg8Zj00IM+N7XjOo+IMCVPSJ7M2qP
         K6synTw7ukH3WviZOWhCpx2DYsECXifCYNISkWuio2XlFH77mJDu8BEixkvLV3JZz8H/
         ZzTBx07EBlfvjdLA/z9jr+Ico86pPlPePC919IEK1ZDG3jUkg5y098RuHbj8LOtu/M7e
         liY8ziu+RByk96YxTLjXeBdcJWligOpbv7msrO4s+J4SRbio7JXiW2Iso1zgnpaEJAbi
         myuA==
X-Forwarded-Encrypted: i=1; AJvYcCUMSTnB+vVJDhu+LA1FodWznvoGquA6l5xiCh3fOyx1PYD4nnasOzaEsAdAcjx5BHD2ObDb8MhHf1vvUo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP3mhzg/I+XNQ5tXysH3foW141M1hfDUxM9AKUYsefVM6TJi+W
	+sN7CdPekLV1XGBdjIde8n6CmAs/1XmKGVIL0TIvyRfdjaFZ5eV+5GbBSDcCnntHXHH33+OATbH
	nV/xgus6Ty6zMIwx0i3gifUrzlxOYoZVGvbrla0pL6g==
X-Gm-Gg: ASbGnctNdDO9fyW/Tqdj0lQHZI1txBy6gQ+s952OFJySs9Gyg5aH03sI+fk4iUTjuAg
	iXIevRJ4t3/7TsL2/OvwTr7d0UENdwzUhX2QlL31VYGqRAra4N1RssLEZ6xT8Urlb4rpIRmGLWp
	+TZqZ45Cz7G4eGw+MwhbUdGhGCvLkxpa2QaLBc7abI6vstUCVDYk6nJzvXx4ReMHQGxis0TXUiz
	bOUNoHUB1qwpAVRUXehyt6wKCuBlXqBZTrmngjLngx0qiRZYoPY9tlaWdzw6ztXDA==
X-Google-Smtp-Source: AGHT+IFBvtsDmLFlrUPLrEdtXlj3XmnDOunMGaQVNwpHnx7V9K8cWA1KerJzVQIV4Og+xzCob2fZntJ3zIqyp+GB2lY=
X-Received: by 2002:a17:907:3e1f:b0:b04:2b28:223d with SMTP id
 a640c23a62f3a-b1bb6048f2cmr368398466b.20.1758140746182; Wed, 17 Sep 2025
 13:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917135907.2218073-1-max.kellermann@ionos.com> <20250917202033.GY39973@ZenIV>
In-Reply-To: <20250917202033.GY39973@ZenIV>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 22:25:35 +0200
X-Gm-Features: AS18NWA9lLP5Eqngelj0xlWoIoGVHH7XtsnclhYX2neNhHDUumPEaBrniNeVLQk
Message-ID: <CAKPOu+8eEQ6VjTHamxZRgdUM8E7z_yd3buK2jvCiG1m3k-x_0A@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Mateusz Guzik <mjguzik@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:20=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Wed, Sep 17, 2025 at 03:59:07PM +0200, Max Kellermann wrote:
>
> > After advice from Mateusz Guzik, I decided to do the latter.  The
> > implementation is simple because it piggybacks on the existing
> > work_struct for ceph_queue_inode_work() - ceph_inode_work() calls
> > iput() at the end which means we can donate the last reference to it.
> >
> > This patch adds ceph_iput_async() and converts lots of iput() calls to
> > it - at least those that may come through writeback and the messenger.
>
> What would force those delayed calls through at fs shutdown time?

I was wondering the same a few days ago, but found no code to enforce
wait for work completion during shutdown - but since this was
pre-existing code, I thought somebody more clever than I must have
thought of this at some point and I just don't understand it. Or maybe
Ceph is already bugged and my patch just makes hitting the bug more
likely?

