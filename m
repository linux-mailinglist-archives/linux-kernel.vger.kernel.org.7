Return-Path: <linux-kernel+bounces-842203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3462BB9365
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 03:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2AC3BECBD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 01:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4413187346;
	Sun,  5 Oct 2025 01:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="da99MFy+"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DD615B135
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 01:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759626668; cv=none; b=g1Lejf1PBkfT7Gpw4aKm1UA8tek542Ezx9ZqMZEIn/xmHUzbauIBvxVEmuwYJ11U+kj/6nzpZ6xat3wX+gOJDnc97G3EVJdNs1QWLfWzFLHwj9TrgLHWXT0h9niU8S5CMlXF84Rg+SukNcxE1B5Fzv3BAgM2EzIV3Vc7bxp/kVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759626668; c=relaxed/simple;
	bh=CaGXHLH/DXwBBr2/jmC0yukKlVcNAe2XnJ4WlAHZj3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzcueh4QmMGOZycTqywEsKPA/Rwn6l1lDS3NEc+FONgkYUpPzbeFe5rkDmjl2Ec0joKzSGM7kkRjWkNXLCA6F761anHWVhBdU1j48uYrz6NFCmP1wYcyDYwlJ/cJ3KSDeqddr93Y3nA/57j60VVHdHEnBTcrK0HHIkdlyn2afdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=da99MFy+; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b403bb7843eso746795466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 18:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759626665; x=1760231465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJyOkytP/4T7QJZkkLYSODGgdQWKJzRCxXSDdPVWq/8=;
        b=da99MFy+PbMSdweXwWhsDwhN0i59mJA3Cbwr9mx3CuQ15/Z5Nqs8RX1mrD8qLokC45
         8bkHC+rUXg8C6MPXo+yjf22tY6o6z7dZD1FH8Mut61rBl/eW9xgWXzHfFINtI3dAXrIt
         TJa3WBgyQvP1WaEdu9gCG4EDbuhwNEroBFJqChCA7Dv0wHR6bpkYxYmXjnHDohoKGEMr
         ACNwHwrOiv6a2hNyZN2AJi56l9NIZak/7Lim+XX+c52icwaflqlmRJCOj1lA8LZWetSo
         8FlSQlL0iaZ/0YZzZ5/clE0aEZoGRskAVqZ3U+H05ZxbuhkQ+I9PYwL9tijdn5yINm3t
         QRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759626665; x=1760231465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJyOkytP/4T7QJZkkLYSODGgdQWKJzRCxXSDdPVWq/8=;
        b=nE1gSq49yu6QU2Bal1587P/ViUrKKtuWPy/eNBQwa4AzkzR3PTKy3XZeE8qKjZZngc
         6q7cSZMwLGJMTJa7birMzRGkCaaGonUNCa3B8diuII8vTnAzbzc43mwA2A35UVIwVyUK
         LAo5Iz5s1+XVfwPFX/RiNxso+wh3da8uQYjjOCY+bD91zKS3whjL75XOQntXLHwY5Saz
         0VszXthw/khGGsBwDqV1y7EyBz2LUCZIZVwoGb/Yy8c+PTi80g1EfEe5Mrp8940Nl4xp
         /4ns3wJN/47FLT0foobsrcfouK2HVPXyBovQGjKnhGulmTffq8x8nEkbm5pDVcH9i8GW
         kgNw==
X-Forwarded-Encrypted: i=1; AJvYcCWDLZZgPDbMSzNg3xlQygj3dLJ1OLarGhe9/K8aAVkow69vsuKNIMY09SMoKzl7icT/AYqQ1cMYONOzfoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/t2pWDYD+AhroxDVquVfsoGZoJX2hw+SvqT4IOKnK3kURGAi
	t2nUmcrYk6eJKF77sT8rMJkkWmujAq+f5S4KyqwubCmrf69gd5jF7tkY
X-Gm-Gg: ASbGncvzhP6h6i7cwQE+e2kRv0QW/ylMs4FMV+u+kbUJjGp0EifQALstMJi5XiRBATR
	F5LF9CRQR8vfaJ9Y7sPnuJdwNJIS/JaESmFV8d3qWN074Rr9q5rX08wCxxQQ+8wSJQsGcebUU3+
	ex4oNbOhmKB82AREBKYHfRry/LMQdbRWb7vbTBou/wNgoFKrP7Nsf9nLwySo7wdPvrNXWIA36/a
	PJaSp8m0eihR0BI/s/6eVUnwxgUmXt2dUIoOnmBuIak+0RuaNAAeMu25NykFf7LsqC+D2qvuMcC
	2NWdL32JY/i1ubXUTh+QhC8iFAe0jSr5EZvlKQtm64jqL9qOv9g6ERVdCbSq7tdmYunAbimHDYe
	+rey5DeoIQWqzuZSjJ4Kh6UatD4yUU5v9DHnbx9qxf7Z/Xm3Zz/wnSXYgiG+8vFKJ
X-Google-Smtp-Source: AGHT+IG2JHkZbVmxw0BSVWQUDtAW3CvyW6jcfDbCRqfhUgKCZ1TjqKPOpf4r+o/oGRMoBnsYj084Gg==
X-Received: by 2002:a17:907:3c8e:b0:b31:ec30:c678 with SMTP id a640c23a62f3a-b49c525ee7dmr904311866b.57.1759626664728;
        Sat, 04 Oct 2025 18:11:04 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b48652a9bf1sm802257166b.13.2025.10.04.18.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 18:11:04 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: thomas.weissschuh@linutronix.de
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	gary@garyguo.net,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	nathan@kernel.org,
	nicolas.schier@linux.dev,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: [PATCH v2 6/6] kbuild: enable -Werror for hostprogs
Date: Sun,  5 Oct 2025 04:10:47 +0300
Message-ID: <20251005011100.1035272-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250814-kbuild-werror-v2-6-c01e596309d2@linutronix.de>
References: <20250814-kbuild-werror-v2-6-c01e596309d2@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

"Thomas Weißschuh" <thomas.weissschuh@linutronix.de>:
> Enable -Werror unconditionally

Please, drop this patch.

Never enable -Werror unconditionally for any part of build.

I often bisect Linux. And to do this, I often need to build very old
Linux commits (with modern compiler). Unconditional -Werror will make
this impossible.

For example, recently I found this regression:

https://lore.kernel.org/regressions/197f290e30b.eaadc7bc7913.7315623184036672946@zohomail.com/T/#u

The regression caused by commits happened in 2019.

So to bisect it, I had to build 2019 trees using modern compiler.

-- 
Askar Safin

