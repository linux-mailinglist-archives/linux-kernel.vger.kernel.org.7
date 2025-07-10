Return-Path: <linux-kernel+bounces-725782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8460B003E4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91053170C17
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FAF262FFE;
	Thu, 10 Jul 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XEgfwOn6"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74798262FE6
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154900; cv=none; b=Z03RQ/FAeCynv7dnObLgUpJ9TeNdkJ1h257gx8nsvmDyvpEf9YcFm3+dOSqC35RyH6xj7woPdRLefH+KH08sC2DXkam0SplJ9UDUiGYmRx0dg3WPRoqrfqqRvlUgD+qujr4xbZtKdEwfWGl/2kmEDIOwkopaODKG7SigcH1R7yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154900; c=relaxed/simple;
	bh=Y2cPTKyp8+pa4kvRMd2DbHQIqkwHAegaMbr/kZOwiA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iz3xDNBOBq+r/bi8gjGx1dyoRV5YrPnGhzmBBllPvTpjaHQSAe8kSfwNCN2kYPIAX/Yh1fd8ywlx8EGtK4Pd4mztS7CbqvoKjenD8rJVpGoH+gY86uqnDUOjdkiadLsmKz1Wqw1poSXHPVzj/ipkJM3NM4zyCe4P+glFhoIu1Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XEgfwOn6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0d7b32322so149259966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752154897; x=1752759697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2cPTKyp8+pa4kvRMd2DbHQIqkwHAegaMbr/kZOwiA8=;
        b=XEgfwOn6lEE9/qgA61ga1NXFOke9ca1L74o1p+WZjkWJ/CM8+cXLpM0vWp4RAJlLmt
         E8/aZmPgy+LXVRv48r6krjog3A0x17OhAewlZxL7OkaVnj856GbgLsg2QB1/aszz39oz
         BuY+cNeHTRWSvj0R0JYI/b7eQdDRE+7TgV0Li1xTF+K9owuvbD/axBa6hxrc6Q9cFS3n
         4q6nkCk8BMNizCuUGd07o5psDhI48EXo+KMKRTMof/QYIrsbZGFdKDjw4hsPqpt/0OH5
         NCfpXVYRoeOdWeXWxUuAsZ3kndaSvJICAtqmuRNWcPry50hpsC+ldjdkaBZ9kBt8vJ5X
         OxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752154897; x=1752759697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2cPTKyp8+pa4kvRMd2DbHQIqkwHAegaMbr/kZOwiA8=;
        b=rBhNL/z+NReztR5BT1PEyy5BFcmUWjsDg4sUurRxD+E+Z4PyDdZX1Eu+rRxIBmzocN
         Gfs/9A4aY5WGAuIDtgeLK53hXBFqNH//HZa/271G7eyP18LHuELfPeOIsM3i4kw195Kk
         a5sQrTJdVWs4L8bO8fu+ZJ49hFa3l9SiYCX3YtQg+gXXOJlTyMeywGQIlzeKwBHb8c/6
         leV06LaJQlTEKfWvCZ24Kgv9fcIcVAmxQKh+w0qzlrwi0RAERx1RzZAHUOv12yY6k1vu
         xoTw9FCHKjbXzJO78rvHll94elod0QQZ7sW5n8dTf/M6oSYWtjRDCxU88+Oq5PnlmCjU
         vVZA==
X-Forwarded-Encrypted: i=1; AJvYcCUpRR7l2FMBFNsvRdHie3lRfMYzJAn1wUjFKeMJFDd0Tq3joHo9xU4PeCtYecMhuoiU+w8r/FUYPn3iwb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycbKMV7afM/jjqWFK7wOHrbuULWYxTaFh+f14/lbQQGPfx7eFd
	L/M9qsUB08wRYbCNNZQj6oTxLUIBJsiHcRTFT1e4bHbg/8d99dK7SdRdaebQW8AwWJTdlw/I376
	qJkEI4iv6iMHgoCda4pQWYnnduPnmtTevqBk45CrfRA==
X-Gm-Gg: ASbGncuIE9wtkpodJoLl4evceu/qj5DASDqlztTivRJaPseB2fqcDP6GUjBuaTIHJVp
	hWbSczsL69JL+ldqZZRdGgI65gLRkf1ybdF5zwOOZHKDNYUzRZY4OXRXNzKx3p2jIYlGAPjV1cF
	/0zqbSMgppZx9tUlnuvhQFXHTTgEsL4eYmH0IEZRuckxhDzU+F6+MNiXHwhCcfVobRrp23FNw=
X-Google-Smtp-Source: AGHT+IEUfIhpap/ErtxncROC/XukLmMNwnnCP5z2dolLnhei5TAHwMgshdrm44CHSjNOH/5s8BRS/dOJLaexhl9LvyA=
X-Received: by 2002:a17:907:d93:b0:ae3:6390:6ad3 with SMTP id
 a640c23a62f3a-ae6e6ea0035mr262408366b.22.1752154896676; Thu, 10 Jul 2025
 06:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701163852.2171681-1-dhowells@redhat.com> <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com>
 <2724318.1752066097@warthog.procyon.org.uk> <CAKPOu+_ZXJqftqFj6fZ=hErPMOuEEtjhnQ3pxMr9OAtu+sw=KQ@mail.gmail.com>
 <2738562.1752092552@warthog.procyon.org.uk> <CAKPOu+-qYtC0iFWv856JZinO-0E=SEoQ6pOLvc0bZfsbSakR8w@mail.gmail.com>
 <2807750.1752144428@warthog.procyon.org.uk>
In-Reply-To: <2807750.1752144428@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 10 Jul 2025 15:41:25 +0200
X-Gm-Features: Ac12FXzl_JlkX217YnsQK9NDpeOWbIXCejwCEnw4V1qbmZHn5mJ_E34Ih5jkMNQ
Message-ID: <CAKPOu+9TN4hza48+uT_9W5wEYhZGLc2F57xxKDiyhy=pay5XAw@mail.gmail.com>
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Alex Markuze <amarkuze@redhat.com>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 12:47=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
> I managed to reproduce it on my test machine with ceph + fscache.
>
> Does this fix the problem for you?

Yes! I can no longer reproduce my problem.
Thanks, David.

