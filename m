Return-Path: <linux-kernel+bounces-749874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E75B15404
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53113188A167
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF50B2BD5AA;
	Tue, 29 Jul 2025 20:02:12 +0000 (UTC)
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5D7238178;
	Tue, 29 Jul 2025 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753819332; cv=none; b=T+Apcqx0Q/AS4EXxDnkw7GLWGt9bt6CHM98kEM1WwDHDUctYzJvM0v8F7xlamt/nq76qU/0bL8XfFJHLkSok4128TPgMMt2lDCavuxGUQ3sxQD0M0vpxrgXUjwQ+XWUq4CYBRVIUW8a9yg5C7C2ZYv3U2F//q5BAWppte7p+krk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753819332; c=relaxed/simple;
	bh=eryaMuRCjeV6T06EGaRYxeGE9Zx4okUcZhkD2Gjb038=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ei6xre6sJZ8eMSLqC3vrctOD0lvuxOkhXd3IKtVvSa3ynGYwGSEROnJm6NfiWvj0+97YhhhEQYTrzErtJhdGmbviiffSF1XjjEAMtc0rhWEEAVE7wZYENLqy7ALiFUtl6pSgZv3vVoLJI9g63eGPB/eraX4VJ1vLifUIr0FX7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:d071:2bab:ab9:4510])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 1FAE240202;
	Tue, 29 Jul 2025 20:02:07 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a02:8084:255b:aa00:d071:2bab:ab9:4510) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: joe@perches.com
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	apw@canonical.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	dwaipayanray1@gmail.com,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	lukas.bulwahn@gmail.com,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	Arnaud Lecomte <contact@arnaud-lcm.com>,
	Miguel Ojeda <ojeda@kernel.orgs>
Subject: [PATCH 2/3] checkpatch.pl: warn about // comments on private Rust
 items
Date: Tue, 29 Jul 2025 21:01:58 +0100
Message-ID: <20250729200158.35050-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729195615.34707-1-contact@arnaud-lcm.com>
References: <20250729195615.34707-1-contact@arnaud-lcm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175381932809.13506.17895493370658286828@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Add a new checkpatch.pl warning to detect //-style comments above
private Rust items that were likely intended to be doc comments (///).
This helps catch documentation that won't appear in rustdoc output.

The detection uses multiple heuristics to identify likely doc comments:
  - Comments containing markdown
  - Comments starting with an imperative tone
  - Comments with mention of params
  - Comments with code block
  - Comments with keywords: Returns, ...
  - Block comments longer than 3 lines.

Comments are only flagged if they:
 - Appear above private items
 - Don't contain obvious non-doc patterns (TODO, FIXME)
 - Score sufficiently on heuristics

The warning triggered then suggests to convert flagged comments to
doc comments.

Results
--------------------

The following implementation has been tested against real patches:
 - https://lore.kernel.org/rust-for-linux/dc63bdc4bff8f084714e2c8ff30e4c0d435e85b7.camel@redhat.com/T/#t
 - https://lore.kernel.org/rust-for-linux/20250418-ptr-as-ptr-v10-0-3d63d27907aa@gmail.com/T/#t
 - https://lore.kernel.org/rust-for-linux/20250420-nova-frts-v1-1-ecd1cca23963@nvidia.com/T/#u
 - https://lore.kernel.org/all/20250502094537.231725-5-fujita.tomonori@gmail.com

and against a test patch containing:

// Returns a value
fn private_function() {}

// Computes the result
struct PrivateStruct;

// Arguments:
// - x: input value
// - y: other input
const PRIVATE_CONST: u32 = 42;

// Returns [`SomeType`] with the result
//
// # Examples
// ```
// let x = example();
// ```
fn with_markdown() {}

// Arguments:
// - `param1`: First parameter
// - `param2`: Second parameter
fn with_parameters(param1: u32, param2: String) {}

// 値を返します
fn non_english_doc() {}

// Returns something
// TODO: Change this later
fn mixed_comments() {}

// Internal helper
fn indented_comment() {}

// From kernel example
// Returns a reference to the underlying [`cpufreq::Table`].
fn table(&self) -> &cpufreq::Table {
    // SAFETY: The `ptr` is guaranteed by the C code to be valid.
    unsafe { cpufreq::Table::from_raw(self.ptr) }
}

// Trait implementation docs
impl SomeTrait for SomeType {
    // Performs the operation
    fn method(&self) {}
}

// Cases that should NOT trigger warnings

/// Proper documentation
fn documented_function() {}

// TODO: Implement this later
fn todo_function() {}

// SAFETY: This is unsafe because...
unsafe fn safety_comment() {}

// ------
// Not a doc comment
fn visual_separator() {}

pub fn public_function() {} // Public item (handled by rustc)

// some_code(); let x = 42;
fn looks_like_code() {}

// !!! IMPORTANT !!!
fn punctuation_only() {}

// This is just
// a regular
// multi-line comment
fn multi_line_regular() {}

// [DEBUG] Starting process
fn log_message() {}

// <html>test</html>
fn html_comment() {}

// $ echo command
fn shell_command() {}

which resulted into:
WARNING: Possible documentation comment using `//` instead of `///`.
Consider using `///` for documentation comments on private items.
+// Arguments:
+// - x: input value
+// - y: other input

WARNING: Possible documentation comment using `//` instead of `///`.
Consider using `///` for documentation comments on private items.
+// Arguments:
+// - `param1`: First parameter
+// - `param2`: Second parameter

WARNING: Possible documentation comment using `//` instead of `///`.
Consider using `///` for documentation comments on private items.
+// From kernel example
+// Returns a reference to the underlying [`cpufreq::Table`].

Conclusion
--------------------
I think We achieved a balanced solution that effectively enforces
 proper documentation while minimizing false positives.

Closes: https://github.com/Rust-for-Linux/linux/issues/1157
Suggested-by: Miguel Ojeda <ojeda@kernel.orgs>
Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
---
 scripts/checkpatch.pl | 111 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 664f7b7a622c..ac403d270eb4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2007,6 +2007,97 @@ sub ctx_locate_comment {
 	chomp($current_comment);
 	return($current_comment);
 }
+
+sub ctx_detect_missing_doc_comment_behind_rust_private_item {
+    my ($linenr) = @_;
+    my $start_line = $linenr - 1;
+    my $idx = $start_line;
+
+    # Skip public items (handled by rustc)
+    return unless $rawlines[$start_line] !~ /^\+?\s*pub(\s|\([^)]*\)\s)/;
+
+    # Check if it's an empty line
+    return unless $rawlines[$start_line] !~ /^\s*\+?\s*$/;
+
+    # Check if it's a comment
+    return unless $rawlines[$start_line] !~ /^\+?\s*\/\/\/?\/?.*$/;
+
+    # Check if it is a private macro
+    if ($rawlines[$start_line] =~ /^\+?\s*macro_rules!\s+([a-zA-Z_][a-zA-Z0-9_]*|#?[a-zA-Z_][a-zA-Z0-9_]*)\s*(?:\{|$)/ && $idx > 0) {
+		return unless $rawlines[$idx -1] !~ /^\+?\s*#\s*\[\s*macro_export\s*\]\s*$/;
+    } else {
+		# Check if it's a Rust item
+		return unless $rawlines[$start_line] =~ /^\+?\s*\b(fn|struct|const|enum|trait|type|mod|impl|use)\b/;
+    }
+
+    # Walk backwards through non-empty lines
+    $idx--;
+    my @comment_lines;
+    while ($idx >= 0 && $rawlines[$idx] !~ /^\s*\+?\s*$/) {
+		# Stop if a doc comment is found
+        last if $rawlines[$idx] =~ m@^\+?\s*///@;
+		# Clean the line first (remove diff markers, trim spaces)
+    	my $clean_line = $rawlines[$idx];
+    	$clean_line =~ s/^\+?\s*//;
+		$clean_line =~ s/\s*$//;
+		if($clean_line =~ m@^\+?\s*//@) { # Only add comments
+	    	unshift @comment_lines, $clean_line;
+		}
+		$idx--;
+    }
+
+    # No comments to check
+    return unless @comment_lines;
+
+	# Skip obvious non-doc comments
+	return if grep { /^\s*\/\/\s*(?:TODO|FIXME|XXX|NOTE|HACK|SAFETY):?/i } @comment_lines;
+	return if grep { /^\s*\/\/\s*[[:punct:]]{2,}/ } @comment_lines;
+
+    # Heuristic: Check for documentation keywords
+    my $keywords = qr/Returns|Arguments|Examples?|Panics|Safety|Note|Errors|See\s+Also/i;
+    my $has_keywords = grep { /\/\/\s*$keywords/ } @comment_lines;
+
+    # Heuristic: Markdown syntax
+	my $markdown = qr{
+		`[^`]+`               # Inline code
+		| \*\*[^*]+\*\*       # Bold
+		| \b_[^_\s][^_]*_\b   # Italic
+		| \#[^#\s]            # Headings like # Title
+		| ^\s*```[\w]*\s*$    # Code block marker line (allow optional language)
+	}x;
+
+    my $has_markdown = grep { /$markdown/ } @comment_lines;
+
+    # Heuristic: Parameter mentions
+    my $item_line = $rawlines[$start_line];
+    my @params = ($item_line =~ /(\b\w+)\s*:\s*\w+/g); # Extract param names
+    my $param_mentions = 0;
+    if (@params) {
+        $param_mentions = grep { my $line = $_; grep { $line =~ /\b$_\b/ } @params } @comment_lines;
+    }
+
+    # Heuristic: Start with imperative tones
+    my $first_line = $comment_lines[0];
+    my $imperative_tone = $first_line =~ /^\s*\/\/\s*(Returns?|Computes?|Checks?|Converts?|Creates?)\b/i;
+
+    # Heuristic: Code block
+    my $has_code_block = grep { /```|\buse\s+\w+::|^\s*\/\/\s*\w+\(.*\)/ } @comment_lines;
+    # Combine heuristics
+    my $score = 0;
+    $score += 1 if $has_keywords;
+    $score += 2 if $has_markdown;
+    $score += 1 if $param_mentions;
+    $score += 1 if $imperative_tone;
+    $score += 2 if scalar(@comment_lines) >= 3;
+    $score += 2 if $has_code_block;
+
+    # Trigger if score meets threshold
+    return unless $score >= 3;
+
+    return ($idx+1, $start_line);
+}
+
+
 sub ctx_has_comment {
 	my ($first_line, $end_line) = @_;
 	my $cmt = ctx_locate_comment($first_line, $end_line);
@@ -2970,6 +3061,26 @@ sub process {
 			}
 		}
 
+# check for incorrect use of `//` instead of `\\\` for doc comments in Rust
+		if ($perl_version_ok && $realfile =~ /\.rs$/) {
+			my ($start_l, $end_l) = ctx_detect_missing_doc_comment_behind_rust_private_item($linenr);
+			if (defined($start_l) && defined($end_l)) {
+				my @comment_lines;
+            	for (my $i = $start_l; $i <= $end_l; $i++) {
+                	next unless $rawlines[$i - 1] =~ m@^\+//([^/].*)$@;
+                	push @comment_lines, $rawlines[$i - 1];
+				}
+				my $formatted_comments = join("", map {
+					s/\n$//;
+					"$_\n"
+				} @comment_lines);
+				WARN("MISSING_RUST_DOC",
+					"Possible documentation comment using `//` instead of `///`.\n" .
+					"Consider using `///` for documentation comments on private items.\n" .
+				"$here\n$formatted_comments");
+			}
+		}
+
 # Check the patch for a From:
 		if (decode("MIME-Header", $line) =~ /^From:\s*(.*)/) {
 			$author = $1;
-- 
2.43.0


