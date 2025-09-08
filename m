Return-Path: <linux-kernel+bounces-806125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5A3B4922E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C18D3A8194
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F49830C636;
	Mon,  8 Sep 2025 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mb1Uo9Zu"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBAC1C7013
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343503; cv=none; b=Ya8FXOv5uP2QIqJobuLmMvujkgBohn2nNYwiTVO5LTaOnERfZhvGhX927x+e5OtwoQWUZG6igzxAdN2QtUMKMtfem3LH+sH+6Yx9PsdQrB/EDlNRGDFcYOqJHm7qurCk3bhVAo9Q8WG9v3VEU7bEJzaGAedomg00BLwc/Ngrq8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343503; c=relaxed/simple;
	bh=lF+92fwfgVxDorks0tO5XZOYN5o5gxVUZs63Bt3d5cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1to+4JCVAQ1WHqki0Dp8MCN28xtX5+SP1sa7MGYy2/RAW1EJ3TJpJuiwdEBSE+ruHB+BPinzZn+nA3LrtV6K2VOPBJXbkiClFG8I+XG8i4zKOSjM427tX2ci6Xn9wOhu82z5abEpsCNhKz0oojA8c22UU9rNYLN4bhtC5xRfrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Mb1Uo9Zu; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so720950466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1757343499; x=1757948299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3RMLRFrnPHMZ0VFl6Qxdfdx0T7fx+6aNZKVwjS0U42Q=;
        b=Mb1Uo9ZuWYYecoCno4wizLqqTzDkEQgjZOMMQnG4Ogx+3SIf8+JNxEuql89LPdRid3
         bY1JoHUu+0z24ofczodiqa84D0VPnEPTfjbvIcOsfSmS8cx77J0czS+Wc4reSeOy46ip
         xWs4KcPMaL/kyRiUibGKyvkqJdTV2Lqf1ZYLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757343499; x=1757948299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3RMLRFrnPHMZ0VFl6Qxdfdx0T7fx+6aNZKVwjS0U42Q=;
        b=Yn92sRT0jEKbRpkm23K63hxYk9xW1ESVRXJ5mJebn4w7BF7mxIoVSWDpFWyvZ74ELP
         X/3sUfdbZTXHKPJHBqjXXUXS+1wbrhB3UsLe/bNgSyBz8VbElDsUS+vs+Ms4HZtvzscE
         j9QKR5wacLJr8Hyw6e23o7vDaH4n+1xRthMZ62S06wZsB0u+Mhu7uJFq0VIwEGn+jkKm
         L4uVezBa3iliQDygNlnifGHUWI9I0J2NXqRsWmJfq3+GX6r59rfYlcX/cY1kOk/WL/xA
         IltB6Y+pVaImd0oDDQT0gDvlI7EgtM0wyhZep1E32EiyzmfnAQG9eNl/nBE8ELHRJOXT
         Jr1w==
X-Forwarded-Encrypted: i=1; AJvYcCU9Eo9D5/Hnr/u6NM6F1jfUucwGK4Kp+CFH9O+3QoyjEPHQBgoN4NU81puQz9ZcfgUXXmIdUcjzXRTmzNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmszHmmXUL1ZvQ1ihWmz6HF8VHiIbP9FS4DtoQjW09HPsCK/zL
	6iAgpsFzBNnVwbD78cZKdO0XV6D35RDeAJqBqe/qKPK9mFqu5VTK0Ae/UBUppyawY2HhpUvSNgq
	+BwtJ0Jo=
X-Gm-Gg: ASbGncvFmgwnIrR7hqUboaCr2sv0klIicct+U8VVyT/d9W7GbG2uaDKzlTAx+ADD6+b
	y7MgAEPr6flsvA4uPho1TzORDV6xlqPrw3OkrZ3QKJgJtxhqlpP2Kv00Yx/J+Cxn+7LNFpp64GR
	ck5dyvj0AmoZLigZQw/MiQxAYWV7bzOhkWLjcMy4drvby+UAWw5or5bLatVOlo7m+5FmqIHQQ+L
	O7pQkdvXGOhn37TRH3nAGhk8ssg1aBMVnI3ICnzc8wu8qHub672uxzZOTcdbUryMlQgqTFNVODd
	tkJML1kV0jbrb3iXFveTKq+pohGWvEb7CzA/iJlgfONUf865ml+W1un+TxIXsT1LuoXsbKXyW+4
	cv/tSAxZAqpzMrCJXcmH9og4nEgOT3pTHFoiVPnwac/EkL79xgO+WNfXXiNLunePlgKsAbL5Ayz
	4PYdTTJiM=
X-Google-Smtp-Source: AGHT+IEjFa8izZunheLvnM9AYxpWpmfB/T/iApmzCmdG+weG31AqYDFQPumo09VXt4Hx6v3itLnFuw==
X-Received: by 2002:a17:907:78c:b0:afe:b878:a175 with SMTP id a640c23a62f3a-b04b16bf720mr782122066b.46.1757343498786;
        Mon, 08 Sep 2025 07:58:18 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b075646b1dbsm150480666b.15.2025.09.08.07.58.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 07:58:18 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62205eb63f9so4645371a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:58:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQa9MFpWC9g0pryBcyd1z5xVI/XTo+jHZT/JES1/gCfBxOHvQfUJi6q2MuFf8zO616bBm6sZoV0hmbjkc=@vger.kernel.org
X-Received: by 2002:a17:907:7f25:b0:afe:8b53:448f with SMTP id
 a640c23a62f3a-b04b1453dbcmr874541166b.16.1757343497621; Mon, 08 Sep 2025
 07:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-vfs-fixes-0096f8ec89ff@brauner>
In-Reply-To: <20250908-vfs-fixes-0096f8ec89ff@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Sep 2025 07:58:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjutitpc0F8fyCcJhb55UT_sB_5dLNmtxDAVAwxsYSDWw@mail.gmail.com>
X-Gm-Features: Ac12FXxJC42sHTH1eY98TWco16_KITp_O1bkq650MzDTWXsl7jJWyl4wI3yEGYw
Message-ID: <CAHk-=wjutitpc0F8fyCcJhb55UT_sB_5dLNmtxDAVAwxsYSDWw@mail.gmail.com>
Subject: Re: [GIT PULL] vfs fixes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sept 2025 at 02:46, Christian Brauner <brauner@kernel.org> wrote:
>
> the fixes tree was filled before Link: tags were ousted.

LoL. Considering that I've been complaining to people in private for
years, don't worry about it.

Nothing in kernel development needs to be _that_ black-and-white (ok,
the "no regressions" rule comes close, but that's it).

           Linus

