Return-Path: <linux-kernel+bounces-847287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3905ABCA799
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9CC482B74
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D96025228D;
	Thu,  9 Oct 2025 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3KrmDFB"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D8224DCF7
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032730; cv=none; b=FK/hFiIPtC7qP8VguPqrV3p5kg02SqcoDj2jVgrW8x6RNjhpIfG4bwHxS71qt6t55lYyk9zo8q5ai8c237/r+UXxJUwXG/tvClT90Cc/xb14zWw4vF01t3bpTqcdqQYbLW5O5/Ylu/6ew1h6cLa4W2Kjdpj6IgW1WemeahsrG1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032730; c=relaxed/simple;
	bh=sPUfeSm5BrFc1JGDfQfBW2rqApZnuuum7JmLHXwQcOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFb+b7WhJHJa1Bp+Qow+BtAm2pWZxSYkSUzPdZwaAG9p8wN/aLK8kqLpuGyVVs1Vjsm2XwumkIZmdA/IYDUpUb24CZfda8djRKZdp0v9QbgSt+PGr+Fkt1eIbcyUAwyTGLmf6c/7LtsZRvMhs5YSD4nIOpbnrMycpsCqizJN4A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3KrmDFB; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-428551be643so10120705ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032728; x=1760637528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upmZ+84nb0PGLfZ0odEvQVtU0YnnK5GejiW4j5Z157Q=;
        b=A3KrmDFB7e23eDhEMzJ6oDTmsewP4fjscQ+2lLI1HJo2+FGQnu5fm0JG91TuRcoTba
         qYWiYnYLwYUdQSOgb71iRjogZwdwrNJ9PCr17kwYZLqm3ywxWfXFXYqpziv2jNqwltcj
         Pk/xhuVzZhmsK197H3lnt5JP6aJtNDp1S7THzYSGPkz0s3C6+kpTAcBls8NlN4LlLJwH
         H1nzjOOi3fnM5N/PrXpDJc1KErssx7wX4r2tAhpmQjrEhCP36/ZhJhom2RaeWRPi0QNH
         +zX5lH3wbSDIw9NqJsAqqUNNfWQe0qmhbRKPhfKSZ59haGRTsQlfFZCblQ5ipaQ+6RLX
         m6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032728; x=1760637528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upmZ+84nb0PGLfZ0odEvQVtU0YnnK5GejiW4j5Z157Q=;
        b=kJkxPunYvD0x3jKWro4+X36yXg91JbLJCx/SAhSInvhNJ/z4IFwFz7dCJz095FbVib
         sns+CYaMh6UUxXeNJ33eFCayKmhTip7UMhljzX+49v8Zy3mEbtHKhQ8R2IYdurkl5/XX
         bSseIVExob17H7ju1yBxIZKGrtH0mjYONVOPF4aXd1h3KcKqHVNXklh8H/fWT7DEbrBB
         8HjLjvunPzPTu8tJMM/qMnVDkIeDkQbQ9E7yYreRIzhNCrtNTgUVLIRyUYYMKpUnKmgY
         L/QVD7wZK1JF33kSGqtYCD3VTObURDvSSRAQslaXA/g9UKvgrlQ5ALDr3V0SCIecVtDK
         lSTA==
X-Forwarded-Encrypted: i=1; AJvYcCUbm4B8fHJYTbTBnTanuVtyuksd8IzvYdrnFHmgf2tX+wH9eatAGs5Ti+2PY/nFSVLY2xwWvUNVb8Qd+LI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdf1HN0q1IRNPV3wJuVSDDSSzjwrvvkivV51vUKiOtjeOzVuZ1
	AsZUy0IJmPn3HCO4sgJkg9J9Ld+m6GJOopjmsXqXf4uP3waWxRhiT+5m
X-Gm-Gg: ASbGncsT/fFlvANgEnl8bHfOdIBDayA6PBY0Fidh1cGinQguwWt48jJI0z9QTCflKYa
	hbT1IqeVyN7+mEplEl9LQCV7lnD2qTvg9hW+KPRE/JLv+Q0QRN0soU3JhVgoMJtX9mk1In+Csyx
	LcPoK+yFVksG8Hd6rivnRz53CDOPAN0ht+MJJMH3/6oi25Wm8F0a09szI1HOTG0Q1k5mqFcLBlP
	DN3h3mvLMSkghQmzBwe4GD0jE27GNgZYpcqxUhpRAPibSZYY7jPFfwsqTo+HBXSnZP0d8jQ3Kr4
	CrCjTKR5AGj7krHKzqnpZB+/3b19NZue34AJ55u9BwduSHtdP+jkuhtDDuqfWv6W++rFYDCivi4
	ll63uTaEkYDVhCFlI/GeoZqxWiAQLb5ywOuvK11uXcAp3xhKezlkDuV6A8XTHp1JSEbJiI3sdyp
	QOSg+NlZqGSrDiHLMdw0kobX11niDVo/UHeh3Tp+2XKGISDm3O
X-Google-Smtp-Source: AGHT+IEP/KYeFsU48bhRAsguavBTqOpW4JiVNFuGMdDXElpSwlucCVx3RZG6w7iiJpXxsucAPDZNmA==
X-Received: by 2002:a05:6e02:18cf:b0:42e:73f7:79c4 with SMTP id e9e14a558f8ab-42f873fb613mr81674845ab.27.1760032728078;
        Thu, 09 Oct 2025 10:58:48 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:58:47 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH v5 02/30] docs/dyndbg: explain flags parse 1st
Date: Thu,  9 Oct 2025 11:58:06 -0600
Message-ID: <20251009175834.1024308-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009175834.1024308-1-jim.cromie@gmail.com>
References: <20251009175834.1024308-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When writing queries to >control, flags are parsed 1st, since they are
the only required field, and they require specific compositions.  So
if the flags draw an error (on those specifics), then keyword errors
aren't reported.  This can be mildly confusing/annoying, so explain it
instead.

cc: linux-doc@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 4ac18c0a1d95..63a511f2337b 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -109,9 +109,18 @@ The match-spec's select *prdbgs* from the catalog, upon which to apply
 the flags-spec, all constraints are ANDed together.  An absent keyword
 is the same as keyword "*".
 
-
-A match specification is a keyword, which selects the attribute of
-the callsite to be compared, and a value to compare against.  Possible
+Note: because the match-spec can be empty, the flags are checked 1st,
+then the pairs of keyword values.  Flag errs will hide keyword errs:
+
+  bash-5.2# ddcmd mod bar +foo
+  dyndbg: read 13 bytes from userspace
+  dyndbg: query 0: "mod bar +foo" mod:*
+  dyndbg: unknown flag 'o'
+  dyndbg: flags parse failed
+  dyndbg: processed 1 queries, with 0 matches, 1 errs
+
+So a match-spec is a keyword, which selects the attribute of the
+callsite to be compared, and a value to compare against.  Possible
 keywords are:::
 
   match-spec ::= 'func' string |
-- 
2.51.0


