Return-Path: <linux-kernel+bounces-826463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9D5B8E964
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 01:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A408F3B870F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C899A2D0601;
	Sun, 21 Sep 2025 23:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpBxzyam"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B5F24BBEE
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758496115; cv=none; b=WMnsiE4JAF3kqMpWVi4GyD8w7vp08ppob1f39Pmi9MoAZeNYEM3mvc+Zf357JFJKLgfPmUY1KPT9H5jfTZp8phsJH5FYmsE5LkKakFJQRNcxIkLLGscL4Zmx0lj3Xf7fVTwbKozJOYg7BDX1vcWViq9nIjQSQJYE1H3wXXnQjjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758496115; c=relaxed/simple;
	bh=kp7sTRbvQCXDyuEv7lCMhx18j8NoJQstWz5bEdlO6i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PvcHi6MctlZCeC5QsfU+TF4zfjI714yCgQBavMNaOWwa/dhoI/bblacx/I+OJs9cLPGf47T/glFd0uoKD6oFKsj6RXyU5GeaTCRFYAWjKhE1o1bGxGCrGiIpQ9+kYBGjXfwolMaR5/+9u+EOFqYAQIF5BC4v5G9iCTL8OJrGhgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpBxzyam; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b07d4d24d09so633824866b.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 16:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758496109; x=1759100909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tuSy0V0l07vFSFy9Q6h9CIcImr/SidadizJrDYoMvw=;
        b=TpBxzyamd3UoBsYuC7Kxvt8fyDLb5JWbAeYqjsLW+uE1kscQ8YDM0fE39a+IZJDj4p
         6FvQ6J3Y9eySk9poPZpSf5HrlBLc7dNhHUKSdTp8xGK/btqZtp8G55HthLKgzS3ivoJj
         CzHvMqA5TGUHWXoUCxHUAo7gse9eaK607GuXpAJ9SQijVj9/jvG8RbYJOe1v71Yrc+0s
         /VUNWWm8Pvn/qO7nNYSnXwK77iVE04NvWL/q5uJlMBRDVx8CA/t/StpdpYT2Wr1iuaGV
         W3fpq3NRoVVvKT5BzBBS2z/Nyj0SOCRRJ21eckXkrz59rmoZQdEjRDqadKWlgOkQg8ny
         lpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758496109; x=1759100909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tuSy0V0l07vFSFy9Q6h9CIcImr/SidadizJrDYoMvw=;
        b=wwrFT4b8m5nIG4mvEyUFZYRVtdaAvNMU4gBfTgo/WwZQe1gbxF4VHt9koi6yKZRkgy
         UXU174CYHjmvQywVUW0p4iPrOU5tABX3d+Y8ZffisFKKNkqur0KNLOPmkm3Yqcl4gy/5
         KbAjmXHkU0vhFUkx/1qjQULFqEH3y5NHRJp51OwvxFw+57Dohu8tka7zPKAkLwnJ79SP
         wb3WtsZjiAP9oU5VCAythx7V/Hr0op1MM4I7Ia8pzED1/F7msUViOlhsVlWJ1sRSwxFI
         xDsMo++KTkc5SE1ItQrLqf61Nw9xxBDRzY17TpP1wSCIU3ynbdoagVdk7KlZpCPwlw20
         j4iw==
X-Forwarded-Encrypted: i=1; AJvYcCUHoV2v6casjQL4Ujtj4OSTCBtVN3uGSq9uoeuulf9I759vNHLJtIhn4NXdrvhsSvxRDKF27chI0wRWwqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YybwXBstqdHe9bX8rnmHiWfetuQmIenrfURTq3lTwDZ1s9NqUGk
	7IpEAIUZEtcnqEJBCIyYnERmhF4muuWLP9BdUFEPxm+aElrpZEMxS+JV
X-Gm-Gg: ASbGnctkiwGp2cO70fe1ZOakOnWKiqWPwkBINvMFEpp2XrhEVNPi91DAeVq2+75Q8HX
	80vUlodvXzjj/kkC8jmB62ObYcL22uFVkD3/+KQ7/zHDJLT/+Wi8jYDFjafJfAXNOroNiUgompA
	AGR74+vzmKZwfP4yKViMpjq6LXpvnPmCiLuh/r5q/l9beG8q35z2wDm5tYkvyhu3oycibnIj303
	SuznP+HhFbC8C9K01BMI/nS02lIeabLrAqct1Tm/dI+SHORopoJPCK6U6Z6ICc+vsGzdWTWKjh/
	7Hfs/3iTFQaYvSvAW57Q9vJv8f3EzOZa8nzomgLTQ/8ROgNJnMMh9i9ff5OYcxNoMbA1GTAkwt9
	JYFo4dbeCJ6EeU9ZRniw=
X-Google-Smtp-Source: AGHT+IGaYL0rZYaG01O9JWNyxpX9QMFT7dX6PEZPc8o/39RX71pF0AyzIyHiFTeTuo7PDhxHHUV32g==
X-Received: by 2002:a17:906:6a19:b0:b2c:b12f:429b with SMTP id a640c23a62f3a-b2cb12f63f9mr126937766b.62.1758496108686;
        Sun, 21 Sep 2025 16:08:28 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fcfe88badsm941730566b.52.2025.09.21.16.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 16:08:28 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: cyphar@cyphar.com
Cc: alx@kernel.org,
	brauner@kernel.org,
	dhowells@redhat.com,
	g.branden.robinson@gmail.com,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-man@vger.kernel.org,
	mtk.manpages@gmail.com,
	safinaskar@zohomail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 05/10] man/man2/fsmount.2: document "new" mount API
Date: Mon, 22 Sep 2025 02:08:18 +0300
Message-ID: <20250921230824.92612-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919-new-mount-api-v4-5-1261201ab562@cyphar.com>
References: <20250919-new-mount-api-v4-5-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Note that the unmount operation on close(2) is lazy—akin to calling umount2(2) with MOUNT_DETACH

MNT_DETACH, not MOUNT_DETACH

-- 
Askar Safin

