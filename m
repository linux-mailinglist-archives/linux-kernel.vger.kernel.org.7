Return-Path: <linux-kernel+bounces-729963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D391FB03E51
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AA8188E291
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62976255F56;
	Mon, 14 Jul 2025 12:06:39 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468331FBCA7;
	Mon, 14 Jul 2025 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494799; cv=none; b=rNUSWeND61LFuxRd9JmIp+xp35b5WjZ8jdwZNevxDzXl6SFCaikChCV3BCk91dEVtI3OZb6nJ2+f0wsUdlgCxNgryXuA0tOabGLCBWHAd5RfGx5abQWsdzL40y7NrbpowOQluzM2fUBuFmPhYuLmB+U3D814m2Yc4ZHt3yXDlL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494799; c=relaxed/simple;
	bh=jyKF8fukPkvqUEz1+31oAWoM4hg4RgCAuMgyvrXqcEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=me//7pXoVwc6KGTweKqkjSsKh7UapcWyuLnCb7gMQ4S+s6j3YeYv3gtl1iAWZjAwclQM2TDLe4i4H2EV7pCnFIwK4s/fwBP90Hcn6hoX1va2PZyvAfNcnBWs5+1wwIsFOQEnl5Rx61IYAYc61XuW9j3a9+BGy3llWAEEobYe8MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0de1c378fso687034666b.3;
        Mon, 14 Jul 2025 05:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752494793; x=1753099593;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QnE8NcmRUhh5gLGowKcxUkNoDsSW0JZa2ifNZ2DC4io=;
        b=p/3HGi3tVlQpDiPJm9Ay5o9l9kMow8m+/5jv20hFn+jpD7WbKWCV/oxkjx0j2dHbEU
         ZaT384S9uyzFK/mNtCqu2/HUoyB000zNJPOFqUslT4amcn5s8I5imku+Cedlo25uE+GV
         OLQcq1WqnKV1cKkWWjNJMvszB++QUEvZXQMibFrhj1l1uQZYSXqAolKxOiMgjwNOCohT
         E+ZWgkn2Xvo1nqwd0nlbQMvldvdTBlC3tUeWmi3tDayyO7UOTCjXXdowHgCICFcFMaWN
         7JoHnyiJ08kaMzPAj82qOJb8XHvu261CmUekRccgrf+uQsxQsoO9EZmj6Ap5fCKd/D5o
         RYlA==
X-Forwarded-Encrypted: i=1; AJvYcCUFY80IuOFnQjAKoc0EEsl17IzT4eN1uHMctOV/t+fECx5IbnE9pPLUYxouex9ju1Bd7dJwl3Qrsovz0gGh@vger.kernel.org, AJvYcCX3pCaAiq60z93rapupACGrf1BEsf9/BAGmqcK9bnEoKB/YT86HasG2qFm6zEDyFVtvY6Ptwa8/8ME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn7WejTkgMDtqsit5EZiFYVdW14GecE83Tg3lbu2idLzIJ9U9F
	du/s1Jm2wl5aGIVkLbW0RN2ymXvbbWEZ4G9ZFiBCXWb3BcjqvTX1npyZ
X-Gm-Gg: ASbGnctK5x5qQojFptiZ8IQaypSqcJOjuIvWwaFNECab7tEjK4gAp0Puoq+kxuYVeI9
	YBJOHAz4xGmdgUX7LgAIiBTQwzF/iXAvSWkOOKb7DXY5zuaqZDD59+pp3HOCFPhXaoWoeSkDQ7e
	nj3FzoXlBr8BMN2m4ZBwI4tYuP4a641Qn34G3os3SP0RaZvfyuY+UDCKYJ3QTj19NyccUeY5Xl5
	CByWvoo0E34NuPedzWCUKjx2IybGWiYwFaPW2Lsr3FaqzzOrxmM0wPcp+nCWb2AmHWm5cvpqk/U
	F/g7Y5hLO8zBPFM9+pQ+H3zG66gFOmtwokbPuZTMIs7qnsTbjnwcbJPDavdhUWOhUe8AEGldSIy
	wt734A9fhynxypA==
X-Google-Smtp-Source: AGHT+IFjL93rz150iKe+jlyv6uDExT4t4gcF9Gf1kGsrwiginPCS9TCgXX/bbH1N5i9tOJTMVleKwA==
X-Received: by 2002:a17:907:86a6:b0:ae0:d9f3:9131 with SMTP id a640c23a62f3a-ae6fbc13fa4mr1315906166b.6.1752494793145;
        Mon, 14 Jul 2025 05:06:33 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e826462bsm815755666b.104.2025.07.14.05.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 05:06:32 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 14 Jul 2025 05:06:27 -0700
Subject: [PATCH] docs: kernel: Clarify printk_ratelimit_burst reset
 behavior
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-docs_ratelimit-v1-1-51a6d9071f1a@debian.org>
X-B4-Tracking: v=1; b=H4sIAMLydGgC/x3M7QpAMBQG4Fs5vb+tZgi7FUmLM075altScu/Kc
 wHPg8hBOMLSg8CXRDl2WMozwri4fWYlEyzBaFPpOi/VdIxxCC7xKpsk1fjSFdqbttUNMsIZ2Mv
 9h13/vh8QLu7rYAAAAA==
X-Change-ID: 20250714-docs_ratelimit-8f4a30f29908
To: Jonathan Corbet <corbet@lwn.net>
Cc: paulmck@kernel.org, pmladek@suse.com, rostedt@goodmis.org, 
 john.ogness@linutronix.de, senozhatsky@chromium.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=leitao@debian.org;
 h=from:subject:message-id; bh=jyKF8fukPkvqUEz1+31oAWoM4hg4RgCAuMgyvrXqcEs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBodPLH4BPjVaFjlcy8x+acCa80xWuWYnWZO5eWg
 4Ped0nADmqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHTyxwAKCRA1o5Of/Hh3
 bU17D/94pMXyV0UhQnrKzQX2GpKtyKEzJI2heR7kEoXwaKruY2gRVMMSMj3OqdLR2bbMCxDPEeS
 tpJ5BxuA2fGI5weXgeCfjJ95x3U1DcEhoGw0byw1g5Ux4Rt0MrmZU3i0+yasUTHdKmzhsFRGHpO
 f9HZQJIs2RD4AXn0LWhjBf2guVDYIll6V1QZ2Lto98FWFzmDmUBqgo0xa95GfUy1Aew1znOGOx7
 wSAbost36AGWO+MkCloSbW2fPwQ1veusqc+p2cnnoaXVoqyxdg/TEakQrWMuN3s3bWcs56OiazZ
 0oR5FvWWFyV96MHeNh/mksOgWZl0mj2QHm2CjuBuyGXulXGGabFvop7ovrPKHOosdsf8jUT84df
 8ZHczVNapU2PiRts3DA2WxHcx1I1eRHRHXyd1iPfaa5d4D6Oaz+zS2s93AF12F7DG0aXZPrcW2h
 hYPex35MdVFFdL4D/Ly32Ajs3/ka9ZQVWO7ZNJQl/o3iEp7BPkfhBceL5G4XE/HWJjwhBqkHmzu
 nxx31CwmZ7Ye+R8sU/2GuVFHXMlmebTDe681N/AY5TQrhV0Nw/Sx50Pjn9zhnFc9ke6cxdv3oSp
 pbHkeytsvvkKjiKJFBKRvNkTP9lUVA+mx2mXXo4mJUnWCKBhFtQT/dBmd8lpmp6WUd0G9vMl0Pm
 73IZKCymwVkVyyA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add clarification that the printk_ratelimit_burst window resets after
printk_ratelimit seconds have elapsed, allowing another burst of
messages to be sent. This helps users understand that the rate limiting
is not permanent but operates in periodic windows.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index a43b78b4b6464..6f8d3935147da 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1099,7 +1099,8 @@ printk_ratelimit_burst
 While long term we enforce one message per `printk_ratelimit`_
 seconds, we do allow a burst of messages to pass through.
 ``printk_ratelimit_burst`` specifies the number of messages we can
-send before ratelimiting kicks in.
+send before ratelimiting kicks in.  After `printk_ratelimit`_ seconds
+have elapsed, another burst of messages may be sent.
 
 The default value is 10 messages.
 

---
base-commit: 0907e7fb35756464aa34c35d6abb02998418164b
change-id: 20250714-docs_ratelimit-8f4a30f29908

Best regards,
--  
Breno Leitao <leitao@debian.org>


