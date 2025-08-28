Return-Path: <linux-kernel+bounces-789972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF631B39D91
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56F9172A07
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B37030F95D;
	Thu, 28 Aug 2025 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="JsAgJKth"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA531E868
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384961; cv=none; b=QJM9tFRMcX8gcrgYGhkgnlc0vf8YlV59JpcKbYZ/MIL45fHWSMe0uh6S6FY6jbgZpy8t2fJXUsWPqVq2gReeOb4rRPWvQdcyqz3Ji1ZnGkaf4V6WCGCXLZOtXN58KV9wRgBkcKYWgROdUVw6uCjYvBnd3cSnZFK+ZCh2bWBMvfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384961; c=relaxed/simple;
	bh=GhpMCWe5V/F/7PAyzm0puD9kBtIwTfCh1oTxflApNds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPwQQuugJIJN8LMthz7uoNblCB6Yxr8UCO9Tn9W2TgU3OoV4rbcHAtv2nU/sL+NMNGRYgaX4vyJgBsLtSrLqdMo1KWP2JEQIL3bUqDdPVDsFVmZOtyNgc72lcQd5QFFEdq26CTp6n3zDNlVZ/WpZYOiIDk/rmfnfoQK5eXGk7OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=JsAgJKth; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afeee20b7c0so67738366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756384958; x=1756989758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhpMCWe5V/F/7PAyzm0puD9kBtIwTfCh1oTxflApNds=;
        b=JsAgJKthVJbfOX4ioVOpye0Xsxw8li5qebklhpjN4bp7npGWpjRqLZebTIQ/1EEyP+
         Ahm5MCZAe3mO4AZ48B4g3Tf+qlqjo9dV/IFstn7gHNcNwwwQ4vQPJQIbTLIYbu3ElZsx
         oES3nn07z2+zntjIjCCMQ2RdCBMwmPKo3Hn6r3K3RuSvqMED3Odic4MZ9ss2XuGTwkAa
         Ag+3ISfk7VsY06Ucn0NkRFa+DmcckM5GPuc5G//Ib9uqrv6wElickXdacw0Q6tcOuqeb
         HzmVr1RV15FZM0NjC9JQG+vkY7bzniRhE/DOlVPBX3zFDx4+hWciQwQHnYDmZeEbErUh
         cF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756384958; x=1756989758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhpMCWe5V/F/7PAyzm0puD9kBtIwTfCh1oTxflApNds=;
        b=cfNbBT96oHEDn0HaIW1SfE1/+kzg52sUhxpKyB7C2xsfbrEQWDCGbcHjBLbE2IHOr5
         hsgSE/vo2VpRriuLWuyyr4r1Hyiqqt4EmcWKHMWW2T9TJrJwyFUl/1nLQiYA3aFga94C
         Xl1UHDsZsPho+ojDlJDDVR+M8pAdoALRWl5YLHq265jyVldGtMurtNTHb2/pDoPKLzxN
         4BA/W3Sc0qXr5/5K2G0BZ+DBTxO6kyDc9Fc7+Sf0nk/E6OStWpsq7sMvJXcsyEThPfaQ
         AidVFdrs6GyW1hEFGt7drmB3I2MltSV4mwLhIqwgeeU8JOPaaBIj/tJEwjEA/7hXZRcs
         OInQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUZISarb+HUsPH3NRhQWfj6/wvmsARCuJZ0rILzFVUX9ZTkqLNHq0dkdzbzICctLpw7jjPNByTWSlbsiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYuYnU25GEHPFerzTxLwSj293s+nKHjJ7pPebXaCs+L7dvMsJA
	SNN6GcW2M3Bks0uhVfwVgEeoRDWUVx5iW7ePv240u1+ZfLt5JbAbdVeRX8DNAd94ROmqTd94ufa
	imAbs0nQfp474bVIc9gj2PTGmeQHHUXfZzfDsJibtwg==
X-Gm-Gg: ASbGnct88ceodn4cwc+HpguIrXllLH2VN9o7SENel+Y0IkZEEDv6MNjlcsBvLT21r9c
	UAgJmhpxZH0RzQxp/ksD3zmuows3n6S4HbQw4sbjku/z5BLEKj7P4nj3HFwpD2LhgJGW4T/cifL
	IXQSmDU+7Et9xEA6lMXo72olPaXMoHzsBuUzn+3RyXwFRBt9bt7d69KBr/cXzPgAoQGZ9C0S5hW
	jd6FfYRcwrMPT95LuXD31wiSuA0YgKV/hQ=
X-Google-Smtp-Source: AGHT+IEFqGC0QiMn5r3QGUYrEVf2XDNrF8z/feBWXqNoPN6BqcxgASWKggdDBNsOZ7N2Iw0kXM5omUibGVBRKtEqWR4=
X-Received: by 2002:a17:907:3dac:b0:afe:c0be:5ff9 with SMTP id
 a640c23a62f3a-afec0bf30c9mr541232666b.65.1756384958305; Thu, 28 Aug 2025
 05:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827192233.447920-1-max.kellermann@ionos.com>
 <20250827144832.87d2f1692fe61325628710f4@linux-foundation.org>
 <74a33635-3348-4e70-8cdb-16307f839b79@lucifer.local> <CAKPOu+-0zuz-t22RmENiAT7SXTMyRVeHgkCrnLK-Xt-DDxHykQ@mail.gmail.com>
 <56d18767-8b3e-470d-ad60-781a6f17f9d4@lucifer.local>
In-Reply-To: <56d18767-8b3e-470d-ad60-781a6f17f9d4@lucifer.local>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 28 Aug 2025 14:42:27 +0200
X-Gm-Features: Ac12FXwNjswXU0Ay5JE3li-px1S_CvvDr88iUS2o3Te1_iyJNAzZiituBsisJSE
Message-ID: <CAKPOu+-PVcmnYq_xKCE2S1saJ_iW3xDK1B5k=DCttoTsSyBJmA@mail.gmail.com>
Subject: Re: [PATCH] mm: add `const` to lots of pointer parameters
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 2:35=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> I'm talking about const parameter values.

But that's not what my patch is about.

