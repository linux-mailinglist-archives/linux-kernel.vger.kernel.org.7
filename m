Return-Path: <linux-kernel+bounces-728447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9322B02838
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 02:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6761BC3F2F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85F723BE;
	Sat, 12 Jul 2025 00:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J7iRLwLh"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CF9EC5
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752279274; cv=none; b=qphJUKpGdD+tlGMYVTiNWbdnOR5hz7HKb+QoPWpeFoLZ4jDoM9jLuv+Dkl/bCyjslZ+Ecyp4CX3uZDCEjMP5Fhj0DHrvTAtX4GFpT+jsK152DN2o114hCfbGvrS9sHICDlimpNB6WfeCnGUH0OwhK3mM/fUEn4ornzBTk1WpcEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752279274; c=relaxed/simple;
	bh=cLcjKnM3U3RiIiuW70GsqZR+HIdm+nvI5u9I+b+F8sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZeWSkHKIwoMGnOmh3DRDf7OLIZOQzs2ZmjMbJvzil5jbP4a2IhoGpMQVG3u3lvteRCIwdM5Qx/MOMRt7hD0KhMMmAqOmSdH6uEnuTEoFCzlnBLykcDMlm7MSzHv23vzLAJY7J7/osDBdtf+PWGTz6r0MtHtI9t5PJV1+OLxQIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J7iRLwLh; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0dffaa8b2so511779566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752279270; x=1752884070; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=301LQUXukvS8boCVCr92v5vVErZ9TWNKnhkXV52XC3s=;
        b=J7iRLwLhCjkfZgPopSmMtBOBSthcCEHsjY+D0iTsVktm03wEEq+PHVETDueb3FPlTY
         O1tXfMdNvo3StLA0uLCqYQH4j5DSAjSMCnJGmPm3t9iNQFx/6ufF4JEId2Gxte9kbVI+
         XYC1hvomq6WaMxmcM54FY2/560U3BkLxYt96Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752279270; x=1752884070;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=301LQUXukvS8boCVCr92v5vVErZ9TWNKnhkXV52XC3s=;
        b=d9823ETLZ63gXvfhX+7ZmTteziBCbpOuiD4tOX8Kd7RsWXEkb5SuO6faeS+322tZBO
         O6C+bwSHbQaBsGJTd238FOEbvXn989X95a1SJFUfCr4gTNFf2W6VXMtCYuHK8Cl7cAfK
         9+s3EIT3N2V6SBc+V3zvdpJZWz8gDVUS3hGcL15x5PMpl/24HO2ZZ8QZGuS7m2ejI148
         4Zx+bsDbs4iDGYM2vVdg4NSHLp7C92qsPfp9NjMIv8COL/uMQ0nrDnk5jzhSMD2uG4j9
         8PgSFrd2/hYJVtiUIONDGhm6vTLc03ZQm589zJhHeZFii2nP9kYblYUQJsTr90Dpa3iA
         GR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9oXPJPfbK/vUP0HT7kx7kmqiLz3l9kiQR6HzSO54e9Q2xr2JpAsBSIS4eBRBj75HpaJA4ChiPU1n9FI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFfkMnYhibRM9A/d40iJ4/+FlEDkO8HKevqD4YMFBWz076AuqY
	KTrK/qPgJX9yPqg+WsjsvGv2nF/ZyWZ29oGtiA3kaO2Sc94gJ4T/oTfuo0Il+IEk1naWI1bZwiB
	TMk1ut2XcRQ==
X-Gm-Gg: ASbGncubTGLET6zUtqACEZoCHRDOpfFRhEYfhROxkOYzd+Tg7QCOyv0FWr930mAhQL0
	5dv7Id+BhEwCw41o+CAWlLX3yEBk0XH2Hsq6+Z7gt4EOc8akJBQSILW/C+DND6Rt2B9I/cLeBQ2
	vuohnkmNTKI/xdrTTMqAEXupIfIld6h9pDRxHA5YKwQkPGWqQfuCEkY0gOi/9bNqOcjzerLSzPG
	7uq6//WTthkpr95AX8OJc3AkAsSs9Dr3BYy0D2lalKb8275NjhXq9X71zjnXgNO/wv7Un3JADU8
	TT/pxp8TybbeUngKjhWMt/TA9iPrnXE7KMIkKM08dyHhTvUO5JrAWC5mf42WP2T32GZ7Vv1GW5T
	qiI4WM7uWc/O8Q3DvOx3pHxZ3TaoHYz88A99H+XnHCrMTuqGrEoNRDzuuLOmPUDjF/PNh2b9P
X-Google-Smtp-Source: AGHT+IFKM6+gVr+5Do2GFPi/7w5BsbcQvohPpIJWwN9jeyVAZgp4S00XyngqlTYMci6uMr2MZBC79w==
X-Received: by 2002:a17:907:60cc:b0:ae3:f524:b51 with SMTP id a640c23a62f3a-ae6fbc1ab2cmr574467966b.10.1752279269810;
        Fri, 11 Jul 2025 17:14:29 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8266992sm377999766b.82.2025.07.11.17.14.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 17:14:28 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso5031732a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:14:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWuCoJSviAq9ReS81dMi6E7qUCU4qbZhLJY+/PpQheFTn2S+b9OVFh5Ypo+SDYf6jAXaBEIMP3EBKv/3ek=@vger.kernel.org
X-Received: by 2002:a05:6402:2684:b0:60c:3f77:3f4a with SMTP id
 4fb4d7f45d1cf-611e760d861mr4396017a12.4.1752279268042; Fri, 11 Jul 2025
 17:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709193910.151497-1-longman@redhat.com> <aHGONjuRiA3KfH1q@tardis-2.local>
 <CAHk-=wj4gifTA94-11JXKj5Q5TSieu2LXgOauNDC9gbOQRcZeg@mail.gmail.com> <aHGeF7ko_4uXHUgl@tardis-2.local>
In-Reply-To: <aHGeF7ko_4uXHUgl@tardis-2.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 17:14:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbr9_W-_eDD=zBbKt-nf8TQ48YkPXz6CCHafENwOjpGQ@mail.gmail.com>
X-Gm-Features: Ac12FXwZdpk0J_08lCjMwOqoAT6IW365cOkHy74deCJffCnj3hIslfzIVvZRiQE
Message-ID: <CAHk-=wgbr9_W-_eDD=zBbKt-nf8TQ48YkPXz6CCHafENwOjpGQ@mail.gmail.com>
Subject: Re: [PATCH] locking/mutex: Add debug code to help catching violation
 of mutex lifetime rule
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 16:28, Boqun Feng <boqun.feng@gmail.com> wrote:
>
>   [..]  I think another thing we can
> do is adding a kasan_check_byte(lock) at the end of
> __mutex_unlock_slowpath(), because conceptually the mutex should be
> valid throughout the whole __mutex_unlock_slowpath() function, i.e.

Agreed, that makes a ton of sense too.

              Linus

