Return-Path: <linux-kernel+bounces-631044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88068AA8290
	for <lists+linux-kernel@lfdr.de>; Sat,  3 May 2025 22:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3715A7A25
	for <lists+linux-kernel@lfdr.de>; Sat,  3 May 2025 20:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281E7283680;
	Sat,  3 May 2025 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OO7k+/Wd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805EA283C8D;
	Sat,  3 May 2025 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302396; cv=none; b=I0YcVfcj5GoeQFdS6HvVQQLIuYdOcjl6wvkperx/2/Y+x9Ks9fGvJOSwbmwnBCdHg+W/fWnHWXXV6zUOdLihr2z3xikIr6jt2LS6aMaW1xdsLy4tKuGGewp5lu/iKr3w1VpkRenYEzjglRK5uiFr2f3BaJj1u6SlcfOmUkDz4hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302396; c=relaxed/simple;
	bh=BqaEAnyNy3K13S7S9/sMiwjPohQ+/Jf2zGrJdRtOmFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUQms9NpodmBOvJ1vJzdVjrIzxjB4YCPxR6MLITMWWGJL1nD7Jk6NB3WlpHmjwSpU9wATtntEbwYfXqrWcELlCPaAyDW6K7TuBv8ublmRTWh8vwegkQKv6OtW4DXKaqCE521h6pzxfYp/mgTHtwc9O+atvW+kvWX3tEfuygbn58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OO7k+/Wd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56E2C4CEE9;
	Sat,  3 May 2025 19:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746302396;
	bh=BqaEAnyNy3K13S7S9/sMiwjPohQ+/Jf2zGrJdRtOmFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OO7k+/WdSe9mJhDx+xvZuyZR2pM3BYA5f3re43QtAfhfLCQjA/9I0CQtuP1iiJjTB
	 BVaRb16c5yS9ObUEClqgVJ+eczZaQ77ATizuyd4jcFa/7I+UCigGrQOMwg504ACAnR
	 Hjhg9V1OYFIMM3LIXd/kSe8Gapz2abuF46DMwfYL/4uSK083Oq0EnoXmvpyP+a7iKc
	 k4OSWts+cK8p0gheFdYg10UNDlhQ4bH6nORqalB6Hi5oRZaLcwTk0/tR0wUi+C32ts
	 EWGgQV8WHu4liJR+nO5C/+KB1aEHMPUEFH5OLguf3a9/565pycD/uwsGuO/TOnnPMR
	 m2//LkWhZzdbg==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: sargun@sargun.me,
	<linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 16/18] nfsd: remove dprintks for v2/3 RENAME events
Date: Sat,  3 May 2025 15:59:34 -0400
Message-ID: <20250503195936.5083-17-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503195936.5083-1-cel@kernel.org>
References: <20250503195936.5083-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

Observability here is now covered by static tracepoints.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c | 9 ---------
 fs/nfsd/nfsproc.c  | 5 -----
 2 files changed, 14 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 3b1d63d51bb2..e394b0fb6260 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -526,15 +526,6 @@ nfsd3_proc_rename(struct svc_rqst *rqstp)
 	struct nfsd3_renameargs *argp = rqstp->rq_argp;
 	struct nfsd3_renameres *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: RENAME(3)   %s %.*s ->\n",
-				SVCFH_fmt(&argp->ffh),
-				argp->flen,
-				argp->fname);
-	dprintk("nfsd: -> %s %.*s\n",
-				SVCFH_fmt(&argp->tfh),
-				argp->tlen,
-				argp->tname);
-
 	fh_copy(&resp->ffh, &argp->ffh);
 	fh_copy(&resp->tfh, &argp->tfh);
 	resp->status = nfsd_rename(rqstp, &resp->ffh, argp->fname, argp->flen,
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 7581b1ef4183..799ee95cdcd1 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -459,11 +459,6 @@ nfsd_proc_rename(struct svc_rqst *rqstp)
 	struct nfsd_renameargs *argp = rqstp->rq_argp;
 	struct nfsd_stat *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: RENAME   %s %.*s -> \n",
-		SVCFH_fmt(&argp->ffh), argp->flen, argp->fname);
-	dprintk("nfsd:        ->  %s %.*s\n",
-		SVCFH_fmt(&argp->tfh), argp->tlen, argp->tname);
-
 	resp->status = nfsd_rename(rqstp, &argp->ffh, argp->fname, argp->flen,
 				   &argp->tfh, argp->tname, argp->tlen);
 	fh_put(&argp->ffh);
-- 
2.49.0


